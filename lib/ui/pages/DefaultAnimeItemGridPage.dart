import 'package:anime_app/logic/stores/anime_details_store/AnimeDetailsStore.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/AnimeStoreAppBar.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/component/SliverGridViewWidget.dart';
import 'package:anime_app/ui/pages/AnimeDetailsScreen.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef OnTap = void Function();

class DefaultAnimeItemGridPage extends StatelessWidget {
  final List<AnimeItem> gridItems;
  final String title;
  final String heroTag;

  const DefaultAnimeItemGridPage({Key key,
    @required this.gridItems,
    @required this.title,
    this.heroTag,
  }
    ) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[

          AnimeStoreAppBar(
            title: title,
            heroTag: heroTag,
          ),

          SliverGridItemView(
            childAspectRatio: (itemWidth / itemHeight),
            delegate: SliverChildBuilderDelegate(
                (context, index){
                  return  Tooltip(
                    message: gridItems[index].title,
                    child: ItemView(
                      width: itemWidth,
                      height: itemHeight,
                      imageUrl: gridItems[index].imageUrl,
                      imageHeroTag: gridItems[index].id,
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Provider<AnimeDetailsStore>(
                                builder: (_) => AnimeDetailsStore(
                                  Provider.of<ApplicationStore>(context),
                                  gridItems[index],
                                ),
                                child: AnimeDetailsScreen(
                                  heroTag: gridItems[index].id,
                                ),
                              ),
                            )
                        );
                      },
                    ),
                  );
                },
              childCount: gridItems.length,
            ),
          )
        ],
      ),
    );
  }
}
