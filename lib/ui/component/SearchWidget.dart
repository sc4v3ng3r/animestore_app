import 'package:anime_app/generated/l10n.dart';
import 'package:anime_app/logic/stores/anime_details_store/AnimeDetailsStore.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/search_store/SearchStore.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/pages/AnimeDetailsScreen.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../utils/UiUtils.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  ScrollController _controller;
  final TextEditingController _searchController =
      TextEditingController(text: '');
  SearchStore searchStore;
  S locale;

  @override
  void initState() {
    super.initState();
    searchStore = Provider.of<SearchStore>(context, listen: false);
    _controller =
        ScrollController(initialScrollOffset: searchStore.searchListOffset);
    _controller.addListener(_pagination);
  }

  @override
  void dispose() {
    _controller.removeListener(_pagination);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    locale = S.of(context);

    final appBar = SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: kToolbarHeight,
      title: Center(
        child: Observer(builder: (context) {
          _searchController.text = searchStore.currentQuery;

          return Container(
            width: size.width,
            height: kToolbarHeight - 16,
            child: TextField(
              autofocus: false,
              style: TextStyle(
                color: primaryColor,
              ),
              enabled: (searchStore.searchState != SearchState.SEARCHING),
              controller: _searchController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                if (_searchController.text.isNotEmpty)
                  searchStore.search(_searchController.text);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => searchStore.clearSearch(),
                  ),
                  hintText: locale.searchHint,
                  hintStyle: TextStyle(color: secondaryColor),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0)),
            ),
          );
        }),
      ),
      snap: false,
      floating: true,
      pinned: false,
    );

    return CustomScrollView(
      controller: _controller,
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        appBar,
        Observer(
          builder: (context) {
            var widget;

            switch (searchStore.searchState) {
              case SearchState.SEARCHING:
                widget = SliverToBoxAdapter(
                  child: Container(
                    height: size.height * .7,
                    child: UiUtils.centredDotLoader(),
                  ),
                );
                break;

              case SearchState.DONE:
                if (searchStore.searchItemList.isEmpty)
                  widget = _centerDecoration(
                      size, Icons.sentiment_dissatisfied, locale.noResults);
                else
                  widget = _buildGrid(searchStore.searchItemList, size);
                break;

              case SearchState.NONE:
                widget =
                    _centerDecoration(size, Icons.search, '${locale.search}');
                break;
              case SearchState.ERROR:
                _centerDecoration(size, Icons.error, locale.searchErrorMessage);
                break;
            }
            return widget;
          },
        ),
        SliverToBoxAdapter(
          child: Observer(
              builder: (context) => (searchStore.isLoadingMore)
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: UiUtils.centredDotLoader(),
                        ),
                      ],
                    )
                  : Container()),
        ),
      ],
    );
  }

  SliverToBoxAdapter _centerDecoration(Size size, IconData icon, String text) =>
      SliverToBoxAdapter(
        child: Container(
          height: size.height * .7,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 180,
                color: Colors.grey.withOpacity(.3),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.grey.withOpacity(.3),
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildGrid(List<AnimeItem> items, Size size) {
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 6.0,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ItemView(
              width: itemWidth,
              height: itemHeight,
              tooltip: items[index].title,
              imageUrl: items[index].imageUrl,
              imageHeroTag: items[index].id,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Provider<AnimeDetailsStore>(
                      create: (_) => AnimeDetailsStore(
                        Provider.of<ApplicationStore>(context),
                        items[index],
                      ),
                      child: AnimeDetailsScreen(
                        heroTag: items[index].id,
                      ),
                    ),
                  ),
                );
              },
            );
          },
          childCount: items.length,
        ),
      ),
    );
  }

  void _pagination() async {
    searchStore.searchListOffset = _controller.position.pixels;
    if (_controller.position.pixels >
        (_controller.position.maxScrollExtent -
            (_controller.position.maxScrollExtent / 4))) {
      await searchStore.loadMore();
    }
  }
}
