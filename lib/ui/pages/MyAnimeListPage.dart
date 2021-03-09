import 'package:anime_app/generated/l10n.dart';
import 'package:anime_app/logic/stores/anime_details_store/AnimeDetailsStore.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/app_bar/AnimeStoreHeroAppBar.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/component/SliverGridViewWidget.dart';
import 'package:anime_app/ui/component/dialog/AnimeStoreAcceptDialog.dart';
import 'package:anime_app/ui/pages/AnimeDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MyAnimeListPage extends StatelessWidget {
  final String heroTag;

  const MyAnimeListPage({
    Key key,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final locale = S.of(context);
    final appStore = Provider.of<ApplicationStore>(context, listen: false);

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;

    final appBarActions = <Widget>[
      IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AnimeStoreAcceptDialog(
                    title: locale.titleClearList,
                    bodyMessage: locale.messageClearList,
                    onConfirm: () {
                      appStore.clearMyList();
                      Navigator.popUntil(
                          context, (Route<dynamic> route) => route.isFirst);
                    },
                    onCancel: () => Navigator.pop(context),
                  ));
        },
        icon: Icon(Icons.delete_forever),
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          AnimeStoreHeroAppBar(
            title: locale.myAnimeList,
            heroTag: heroTag,
            actions: appBarActions,
          ),
          Observer(builder: (context) {
            var animeList = appStore.myAnimeMap.values.toList();

            return SliverGridItemView(
              childAspectRatio: (itemWidth / itemHeight),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Tooltip(
                    message: animeList[index].title,
                    child: ItemView(
                      width: itemWidth,
                      height: itemHeight,
                      imageUrl: animeList[index].imageUrl,
                      imageHeroTag: animeList[index].id,
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Provider<AnimeDetailsStore>(
                                create: (_) => AnimeDetailsStore(
                                  appStore,
                                  animeList[index],
                                ),
                                child: AnimeDetailsScreen(
                                  heroTag: animeList[index].id,
                                ),
                              ),
                            ));
                      },
                    ),
                  );
                },
                childCount: animeList.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}
