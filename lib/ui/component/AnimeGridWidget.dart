import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/ui/pages/AnimeDetailsScreen.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AnimeGridWidget extends StatefulWidget {
  @override
  _AnimeGridWidgetState createState() => _AnimeGridWidgetState();
}

class _AnimeGridWidgetState extends State<AnimeGridWidget> {
  ApplicationStore appStore;

  final ScrollController _controller = ScrollController(
    initialScrollOffset: 0,
  );

  @override
  void initState() {
    super.initState();
    appStore = Provider.of<ApplicationStore>(context, listen: false);
    _controller.addListener(_listener);
  }

  void _listener() async {
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

    final appBar = SliverAppBar(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.video_library,
          ),
          Container(
            width: 4.0,
          ),
          Text('AnimeApp'),
        ],
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
        Observer(builder: (context) {
          return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 6.0,
                  childAspectRatio: (itemWidth / itemHeight)),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Tooltip(
                    message:  appStore.mainAnimeList[index].title,
                    child: ItemView(
                      width: itemWidth,
                      height: itemHeight,
                      imageUrl: appStore.mainAnimeList[index].imageUrl,
                      heroTag: appStore.mainAnimeList[index].id,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnimeDetailsScreen(
                                  appStore.mainAnimeList[index].id,
                                  title: appStore.mainAnimeList[index].title,
                                  imageUrl: appStore.mainAnimeList[index].imageUrl,
                                  heroTag: appStore.mainAnimeList[index].id,
                                )
                            )
                        );
                      },
                    ),
                  );
                },
                childCount: appStore.mainAnimeList.length,
              ),
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
                  child: CircularProgressIndicator()),
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
