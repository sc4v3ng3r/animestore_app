import 'package:anime_app/generated/l10n.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/src/di/dependency_injection.dart';
import 'package:anime_app/src/features/anime_details/presenter/controller/AnimeDetailsStore.dart';
import 'package:anime_app/ui/component/notification/CustomListNotification.dart';
import 'package:anime_app/ui/component/video/VideoWidget.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import '../theme/ColorValues.dart';
import '../utils/UiUtils.dart';

class AnimeDetailsScreen extends StatefulWidget {
  final String? heroTag;

  const AnimeDetailsScreen({Key? key, this.heroTag}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimeDetailsScreen();
}

class _AnimeDetailsScreen extends State<AnimeDetailsScreen>
    with SingleTickerProviderStateMixin {
  static const _RELATED_TAG = 'RELATED_TAG';
  late ApplicationStore applicationStore;
  late AnimeDetailsStore detailsStore;
  late S locale;
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation scaleAnimation;
  final ScrollController listController = ScrollController();

  static final _defaultSectionStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    detailsStore = Provider.of<AnimeDetailsStore>(context, listen: false);
    detailsStore.loadAnimeDetails();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    applicationStore = Provider.of<ApplicationStore>(context, listen: false);

    slideAnimation =
        Tween<Offset>(begin: Offset(400, .0), end: Offset.zero).animate(
      CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn, parent: animationController),
    );

    scaleAnimation = Tween<double>(begin: .0, end: 1.0).animate(CurvedAnimation(
        curve: Interval(.4, 1.0, curve: Curves.easeInBack),
        parent: animationController));

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    locale = S.of(context);

    final size = MediaQuery.of(context).size;
    final expandedHeight = size.width * .9;
    final provider = CachedNetworkImageProvider(
      detailsStore.currentAnimeItem.imageUrl,
    );

    final image = Image(
      fit: BoxFit.fill,
      image: provider,
    );

    // in the future add an Observer widget to
    // handle the  image predominant color as background color
    //detailsStore.backgroundColor
    final appBar = SliverAppBar(
      floating: false,
      pinned: false,
      snap: false,
      leading: Container(),
      expandedHeight: expandedHeight,
      backgroundColor: primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.heroTag ?? UniqueKey().toString(),
          child: image,
        ),
      ),
    );

    return Scaffold(
      floatingActionButton: Observer(builder: (_) {
        if (detailsStore.loadingStatus != LoadingStatus.DONE)
          return Container();
        bool isInList = (applicationStore.myAnimeMap
            .containsKey(detailsStore.currentAnimeItem.id));

        return AnimatedBuilder(
          animation: animationController,
          builder: (_, __) => Transform.scale(
            scale: scaleAnimation.value,
            origin: Offset.zero,
            child: FloatingActionButton.extended(
              backgroundColor: accentColor,
              onPressed: () => (isInList) ? _removeFromList() : _addToList(),
              label:
                  Text((isInList) ? locale.removeFromList : locale.addToList),
              icon: Icon((isInList)
                  ? Icons.remove_circle_outline
                  : Icons.add_circle_outline),
            ),
          ),
        );
      }),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: appBar,
              ),
              SliverToBoxAdapter(
                child: animeTitleSection(detailsStore.currentAnimeItem.title),
              ),

              // sliver header with tab bars
              Observer(
                builder: (_) {
                  var widget;
                  switch (detailsStore.loadingStatus) {
                    case LoadingStatus.DONE:
                      widget = SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: _SliverAppBarDelegate(
                          TabBar(
                            labelColor: Colors.white,
                            indicatorColor: Colors.white,
                            tabs: <Widget>[
                              Tab(
                                text: locale.episodes,
                              ),
                              Tab(
                                text: locale.animeDetails,
                              ),
                            ],
                          ),
                          offsetValue: MediaQuery.of(context).padding.bottom,
                        ),
                      );
                      break;

                    default:
                      widget = emptySliver;
                      break;
                  }

                  return widget;
                },
              ),
            ];
          },
          body: Observer(
            builder: (context) {
              if (detailsStore.loadingStatus == LoadingStatus.ERROR)
                return SingleChildScrollView(child: buildErrorWidget());

              if (detailsStore.loadingStatus == LoadingStatus.LOADING)
                return Container(
                  child: UiUtils.centredDotLoader(),
                );

              return TabBarView(
                children: <Widget>[
                  _createWithSlideTransition(
                      child: buildEpisodesSection(),
                      animation: slideAnimation,
                      controller: animationController),
                  _createWithSlideTransition(
                      child: buildMoreDetailsSection(),
                      animation: slideAnimation,
                      controller: animationController),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _createWithSlideTransition(
      {required Widget child,
      required Animation<Offset> animation,
      required AnimationController controller}) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => SlideTransition(
        position: animation,
        child: child,
      ),
    );
  }

  Widget buildEpisodesSection() {
    return SafeArea(
      top: false,
      bottom: false,
      child: CustomScrollView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          (detailsStore.animeDetails.episodes.isEmpty)
              ? SliverToBoxAdapter(
                  child: _buildUnavaiableWidget(locale.episodesComingSoon,
                      iconData: Icons.update),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var episodeId =
                        detailsStore.animeDetails.episodes[index].id;

                    return Container(
                      color: Color(0xFF131D2A),
                      margin: EdgeInsets.only(bottom: 4.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: .0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => VideoWidget(
                                          episodeId: episodeId,
                                        )));
                          },
                          child: Observer(
                            builder: (_) {
                              var isWatched = applicationStore.watchedEpisodeMap
                                  .containsKey(episodeId);

                              return ListTile(
                                leading: Icon(
                                  Icons.play_circle_outline,
                                  size: 34.0,
                                  color: (isWatched)
                                      ? accentColor
                                      : Colors.grey[300]?.withOpacity(.7),
                                ),
                                title: Text(
                                  detailsStore
                                      .animeDetails.episodes[index].title,
                                  style: TextStyle(
                                      color: (isWatched)
                                          ? accentColor
                                          : Colors.white,
                                      decoration: (isWatched)
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      decorationColor: Colors.white),
                                ),
                                trailing: IconButton(
                                  tooltip: (isWatched)
                                      ? locale.markAsUnviewed
                                      : locale.markAsViewed,
                                  onPressed: () {
                                    (isWatched)
                                        ? applicationStore
                                            .removeWatchedEpisode(episodeId)
                                        : applicationStore
                                            .addWatchedEpisode(episodeId);
                                  },
                                  icon: Icon(
                                    (isWatched)
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: detailsStore.animeDetails.episodes.length,
                )),
        ],
      ),
    );
  }

  Widget buildMoreDetailsSection() {
    return SafeArea(
      top: false,
      bottom: false,
      child: CustomScrollView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                buildDetailsSection(detailsStore.animeDetails),
                buildResumeSection(detailsStore.animeDetails.resume),
                (detailsStore.shouldLoadSuggestions)
                    ? buildAnimeSuggestionSection()
                    : Container(),
                Container(
                  height: 56.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _removeFromList() {
    applicationStore.removeFromAnimeMap(detailsStore.currentAnimeItem.id);
    _showNotificationToast(locale.removedFromList, false);
  }

  void _addToList() {
    applicationStore.addToAnimeMap(
        detailsStore.currentAnimeItem.id, detailsStore.currentAnimeItem);
    _showNotificationToast(locale.addedToList, true);
  }

  void _showNotificationToast(String message, bool flag) {
    BotToast.showCustomNotification(
        dismissDirections: [DismissDirection.horizontal],
        onlyOne: true,
        toastBuilder: (_) {
          return CustomListNotification(
            imagePath: detailsStore.currentAnimeItem.imageUrl,
            title: detailsStore.currentAnimeItem.title,
            subtitle: message,
            flag: flag,
          );
        });
  }

  Widget animeTitleSection(String title) => Container(
        margin:
            const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: .0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  title,
                  style: _defaultSectionStyle,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildDetailsSection(AnimeDetails data) => Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            _buildInfoRow('${locale.genre}: ', data.genre),
            _buildInfoRow('${locale.studio}: ', data.studio),
            _buildInfoRow('${locale.author}: ', data.author),
            _buildInfoRow('${locale.director}: ', data.director),
            _buildInfoRow('${locale.episodes}: ', data.episodesNumber),
            _buildInfoRow('${locale.year}: ', data.year),
          ],
        ),
      );

  Widget buildResumeSection(String? resume) => Column(
        children: <Widget>[
          Text(
            locale.resume,
            style: TextStyle(fontSize: 20),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      resume ?? '----',
                      maxLines: 24,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: TextStyle(letterSpacing: .2),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );

  Widget buildAnimeSuggestionSection() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Text(
                locale.suggestion,
                style: _defaultSectionStyle,
              ),
            ),
            Observer(
              builder: (context) {
                if (detailsStore.relatedAnimes == null)
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      child: UiUtils.centredDotLoader());
                else if (detailsStore.relatedAnimes!.isEmpty)
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 16.0),
                          child: _buildUnavaiableWidget(
                            locale.noSuggestions,
                          ))
                    ],
                  );
                else {
                  var width = MediaQuery.of(context).size.width * .42;
                  var height = width * 1.4;
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 12.0),
                    height: height,
                    child: ListView.builder(
                      controller: listController,
                      itemBuilder: (context, index) {
                        var anime = detailsStore.relatedAnimes![index];
                        var heroTag = '${anime.id}$_RELATED_TAG';
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 10.0),
                          child: ItemView(
                            width: width,
                            tooltip: anime.title,
                            height: height,
                            imageUrl: anime.imageUrl,
                            imageHeroTag: heroTag,
                            onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    Provider<AnimeDetailsStore>(
                                  create: (_) => AnimeDetailsStore(
                                      applicationStore,
                                      anime,
                                      getIt.get(),
                                      getIt.get(),
                                      shouldLoadSuggestions: false),
                                  child: AnimeDetailsScreen(
                                    heroTag: heroTag,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: detailsStore.relatedAnimes!.length,
                      physics: BouncingScrollPhysics(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );

  Widget get emptySliver => SliverToBoxAdapter(
        child: Container(),
      );

  Widget _buildInfoRow(String key, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(key, maxLines: 1),
          Flexible(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnavaiableWidget(String text, {IconData? iconData}) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData ?? Icons.do_not_disturb_alt,
            size: 52,
            color: accentColor,
          ),
          Container(
              margin: EdgeInsets.only(top: 4.0),
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }

  Widget buildErrorWidget() => Center(
        child: Container(
          margin: EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.clear,
                color: Colors.red,
                size: 100,
              ),
              Text(locale.dataUnavailable),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: ElevatedButton.icon(
                  onPressed: detailsStore.loadAnimeDetails,
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  label: Text(
                    locale.tryAgain,
                    style: TextStyle(color: textPrimaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    primary: accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, {this.offsetValue = .0});

  final TabBar _tabBar;
  final double offsetValue;
  static const _PADDING = 32.0;
  @override
  double get minExtent => _tabBar.preferredSize.height + _PADDING + offsetValue;
  @override
  double get maxExtent => _tabBar.preferredSize.height + _PADDING + offsetValue;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: primaryColor,
      child: SafeArea(
        child: _tabBar,
        bottom: false,
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
