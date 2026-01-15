import 'package:anime_app/ui/component/app_bar/AnimeStoreHeroAppBar.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/component/SliverGridViewWidget.dart';
import 'package:flutter/material.dart';

import '../../src/core/domain/models/animestore_content_item.model.dart';

class DefaultAnimeItemGridPage extends StatelessWidget {
  final List<AnimestoreContentItem> gridItems;
  final String title;
  final String? heroTag;
  final List<Widget>? actions;
  final ValueChanged<AnimestoreContentItem>? onItemTap;

  const DefaultAnimeItemGridPage({
    Key? key,
    required this.gridItems,
    required this.title,
    this.actions,
    this.heroTag,
    this.onItemTap,
  }) : super(key: key);

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
          AnimeStoreHeroAppBar(
            title: title,
            heroTag: heroTag,
            actions: actions,
          ),
          SliverGridItemView(
            childAspectRatio: (itemWidth / itemHeight),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Tooltip(
                  message: gridItems[index].title,
                  child: ItemView(
                    width: itemWidth,
                    height: itemHeight,
                    imageUrl: gridItems[index].imageUrl,
                    imageHeroTag: gridItems[index].id,
                    onTap: () {
                      onItemTap?.call(gridItems[index]);
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
