import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/anime_details_store/AnimeDetailsStore.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/component/SliverGridViewWidget.dart';
import 'package:anime_app/ui/pages/AnimeDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../utils/UiUtils.dart';

class AnimeGridWidget extends StatefulWidget {
  @override
  _AnimeGridWidgetState createState() => _AnimeGridWidgetState();
}

class _AnimeGridWidgetState extends State<AnimeGridWidget> {
  ApplicationStore appStore;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    appStore = Provider.of<ApplicationStore>(context, listen: false);
    _controller = ScrollController(initialScrollOffset: appStore.mainAnimeListOffset);
    _controller.addListener(_listener);
  }

  void _listener() async {
    appStore.mainAnimeListOffset = _controller.position.pixels;

    if (_controller.position.pixels >
        (_controller.position.maxScrollExtent -
            (_controller.position.maxScrollExtent / 4))) await appStore.loadAnimeList();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;

    return CustomScrollView(
      controller: _controller,
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
       // appBar,
        Observer(builder: (context) {
          return SliverGridItemView(
              childAspectRatio: (itemWidth / itemHeight),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Tooltip(
                    message: appStore.mainAnimeList[index].title,
                    child: ItemView(
                      width: itemWidth,
                      height: itemHeight,
                      imageUrl: appStore.mainAnimeList[index].imageUrl,
                      imageHeroTag: appStore.mainAnimeList[index].id,
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Provider<AnimeDetailsStore>(
                                  builder: (_) => AnimeDetailsStore(
                                    Provider.of<ApplicationStore>(context),
                                    appStore.mainAnimeList[index],
                                  ),
                                  child: AnimeDetailsScreen(
                                    heroTag: appStore.mainAnimeList[index].id,
                                  ),
                                ),
                            )
                        );
                      },
                    ),
                  );
                },
                childCount: appStore.mainAnimeList.length,
              ),

          );
        }),

        SliverToBoxAdapter(
          child: Observer( builder: (_) =>
          (appStore.animeListLoadingStatus == LoadingStatus.LOADING) ?
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: UiUtils.centredDotLoader()),
              ],
            ) : Container(),
          ),
        ),

      ],
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }
}
