import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/component/SliverGridViewWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/external/global_declarations.dart';
import '../../../anime_details/presenter/screen/anime_details_screen.dart';
import '../controller/anime_feed_controller.dart';
import '../../../animestore_settings/domain/model/animestore_feature_settings.model.dart';
import '../../../../../ui/utils/UiUtils.dart';

class AnimeFeedListWidget extends StatefulWidget {
  final AnimestoreFeatureSettings featureSettings;

  const AnimeFeedListWidget({
    super.key,
    required this.featureSettings,
  });

  @override
  _AnimeFeedListWidgetState createState() => _AnimeFeedListWidgetState();
}

class _AnimeFeedListWidgetState extends State<AnimeFeedListWidget> {
  final AnimeFeedController feedController = getIt<AnimeFeedController>();
  final ApplicationStore appStore = getIt<ApplicationStore>();
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    feedController.loadAnimeList(featureSettings: widget.featureSettings);
    scrollController = ScrollController(
        initialScrollOffset: feedController.mainAnimeListOffset);
    scrollController.addListener(_listener);
  }

  void _listener() async {
    feedController.mainAnimeListOffset = scrollController.position.pixels;

    if (scrollController.position.pixels >
        (scrollController.position.maxScrollExtent -
            (scrollController.position.maxScrollExtent / 4))) {
      await feedController.loadAnimeList(
          featureSettings: widget.featureSettings);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;

    return CustomScrollView(
      controller: scrollController,
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        // appBar,
        Observer(builder: (context) {
          return SliverGridItemView(
            childAspectRatio: (itemWidth / itemHeight),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final animeItem = feedController.animeFeedList[index];
                return Tooltip(
                  message: animeItem.title,
                  child: ItemView(
                    width: itemWidth,
                    height: itemHeight,
                    imageUrl: animeItem.imageUrl,
                    imageHeroTag: animeItem.id,
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AnimeDetailsScreen(
                              heroTag: animeItem.id,
                              applicationStore: appStore,
                              currentAnime: animeItem,
                            ),
                          ));
                    },
                  ),
                );
              },
              childCount: feedController.animeFeedList.length,
            ),
          );
        }),

        SliverToBoxAdapter(
          child: Observer(
            builder: (_) => (feedController.status == LoadingStatus.LOADING)
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(8.0),
                          child: UiUtils.centredDotLoader()),
                    ],
                  )
                : Container(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    scrollController.removeListener(_listener);
    scrollController.dispose();
    super.dispose();
  }
}
