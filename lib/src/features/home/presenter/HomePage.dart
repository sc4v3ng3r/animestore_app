import 'package:anime_app/generated/l10n.dart';
import 'package:anime_app/logic/Constants.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/src/di/dependency_injection.dart';
import 'package:anime_app/src/features/anime_details/presenter/controller/AnimeDetailsStore.dart';
import 'package:anime_app/ui/component/EpisodeItemView.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/component/TapableText.dart';
import 'package:anime_app/ui/component/TitleHeaderWidget.dart';
import 'package:anime_app/ui/pages/AnimeDetailsScreen.dart';
import 'package:anime_app/ui/pages/DefaultAnimeItemGridPage.dart';
import 'package:anime_app/ui/pages/GenreAnimePage.dart';
import 'package:anime_app/ui/pages/GenreGridPage.dart';
import 'package:anime_app/ui/pages/MyAnimeListPage.dart';
import 'package:anime_app/ui/pages/RecentEpisodeGridPage.dart';
import 'package:anime_app/ui/pages/VideoPlayerScreen.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:anime_app/ui/utils/HeroTags.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final RandomColor _randomColor = RandomColor();
  static const _SECTION_STYLE = TextStyle(
    fontSize: 18,
  );

  late ApplicationStore appStore;
  late AnimationController controller;
  late Animation<Offset> carouselAnimation;
  late Animation<Offset> headerAnimation;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    appStore = Provider.of<ApplicationStore>(context, listen: false);
    if (appStore.isFirstHomePageView) {
      controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
      );

      carouselAnimation = Tween<Offset>(begin: Offset(50, .0), end: Offset.zero)
          .animate(CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn, parent: controller));

      headerAnimation = Tween<Offset>(begin: Offset(-50, .0), end: Offset.zero)
          .animate(CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn, parent: controller));

      controller.forward();
    }
  }

  @override
  void dispose() {
    appStore.isFirstHomePageView = false;
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final S locale = S.of(context);

    final ScrollController topAnimesController =
        ScrollController(initialScrollOffset: appStore.topAnimeOffset);
    topAnimesController.addListener(
        () => appStore.topAnimeOffset = topAnimesController.position.pixels);

    final ScrollController mostRecentController =
        ScrollController(initialScrollOffset: appStore.mostRecentOffset);
    mostRecentController.addListener(
        () => appStore.mostRecentOffset = mostRecentController.position.pixels);

    final ScrollController genresController =
        ScrollController(initialScrollOffset: appStore.genreListOffset);
    genresController.addListener(
        () => appStore.genreListOffset = genresController.position.pixels);

    final ScrollController myListController = ScrollController(
      initialScrollOffset: appStore.myListOffset,
    );
    myListController.addListener(
        () => appStore.myListOffset = myListController.position.pixels);

    final expandedHeight = size.width * .9;

    final carousel = _createDayReleaseCarousel(
      context: context,
      width: size.width,
      height: expandedHeight,
      appStore: appStore,
    );

    final appBar = SliverAppBar(
      expandedHeight: expandedHeight,
      floating: false,
      elevation: 0.0,
      pinned: false,
      snap: false,
      centerTitle: true,
      backgroundColor: primaryColor.withOpacity(.9),
      //title: Text('AppBar', style: TextStyle(color: Colors.black),),
      flexibleSpace: FlexibleSpaceBar(
          background: (appStore.isFirstHomePageView)
              ? SlideTransition(
                  position: carouselAnimation,
                  child: carousel,
                )
              : carousel),
    );

    final topAnimesHeader = _createHeaderSection(
      context,
      locale: locale,
      title: '${locale.topAnimes}',
      iconData: Icons.star,
      iconColor: Colors.amberAccent,
      heroTag: HeroTags.TAG_TOP_ANIMES,
      onTap: () {
        _openAnimeItemGridPage(context, appStore.topAnimeList, 'Top Animes',
            HeroTags.TAG_TOP_ANIMES);
      },
    );

    final genresHeader = _createHeaderSection(
      context,
      locale: locale,
      iconData: Icons.explore,
      iconColor: accentColor,
      title: locale.exploreGenres,
      heroTag: HeroTags.TAG_EXPLORE_GENRES,
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => GenreGridPage()),
        );
      },
    );

    final myListHeader = Observer(
      builder: (context) => (appStore.myAnimeMap.isEmpty)
          ? SliverToBoxAdapter(
              child: Container(),
            )
          : _createHeaderSection(
              context,
              locale: locale,
              viewMore: true,
              title: locale.myAnimeList,
              heroTag: HeroTags.TAG_MY_LIST,
              iconColor: accentColor,
              iconData: Icons.video_library,
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => MyAnimeListPage(
                          heroTag: HeroTags.TAG_MY_LIST,
                        )),
              ),
            ),
    );

    final mostRecentsHeader = _createHeaderSection(
      context,
      locale: locale,
      iconData: Icons.update,
      iconColor: accentColor,
      title: locale.recentlyUpdated,
      heroTag: HeroTags.TAG_RECENTLY_UPLOADED,
      onTap: () => _openAnimeItemGridPage(
        context,
        appStore.mostRecentAnimeList,
        locale.recentlyUpdated,
        HeroTags.TAG_RECENTLY_UPLOADED,
      ),
    );

    final latestEpisodesHeader = _createHeaderSection(
      context,
      locale: locale,
      iconData: Icons.ondemand_video,
      title: locale.latestEpisodes,
      heroTag: HeroTags.TAG_LATEST_EPISODES,
      iconColor: accentColor,
      onTap: () => _openLatestEpisodePage(context),
    );

    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: () => appStore.refreshHome(),
      color: accentColor,
      backgroundColor: primaryColor,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          appBar,
          topAnimesHeader,
          _createHorizontaAnimelList(
            appStore,
            data: appStore.topAnimeList,
            width: size.width * .42,
            tag: HeroTags.TAG_TOP_ANIMES,
            controller: topAnimesController,
          ),
          mostRecentsHeader,
          _createHorizontaAnimelList(appStore,
              data: appStore.mostRecentAnimeList,
              width: size.width * .42,
              tag: HERO_TAG_RELEASE,
              controller: mostRecentController),
          genresHeader,
          _createHorizontalGenreList(
            width: size.width * .42,
            data: appStore.genreList,
            controller: genresController,
          ),
          myListHeader,
          Observer(
            builder: (context) => (appStore.myAnimeMap.isEmpty)
                ? SliverToBoxAdapter(
                    child: Container(),
                  )
                : _createHorizontaCustomAnimelList(
                    appStore,
                    width: size.width * .42,
                    tag: HERO_TAG_MY_LIST,
                    controller: myListController,
                  ),
          ),
          latestEpisodesHeader,
          _createHorizontalEpisodeList(
            context,
            data: appStore.latestEpisodes,
            width: size.width * .42,
          )
        ],
      ),
    );
  }

  SliverPadding _createHeaderSection(BuildContext context,
      {required S locale,
      IconData? iconData,
      Color? iconColor,
      required String title,
      bool viewMore = true,
      String? heroTag,
      VoidCallback? onTap}) {
    final layout = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleHeaderWidget(
          iconData: iconData,
          iconColor: iconColor,
          title: title,
          heroTag: heroTag,
          style: _SECTION_STYLE,
          onTap: onTap,
        ),
        (viewMore)
            ? Container(
                child: TapText(
                  onTap: onTap,
                  fontSize: 16.0,
                  text: locale.viewAll,
                  defaultColor: secondaryColor,
                  onTapColor: accentColor,
                ),
              )
            : Container(),
      ],
    );

    return SliverPadding(
      padding:
          EdgeInsets.only(bottom: 24.0, top: 24.0, left: 16.0, right: 12.0),
      sliver: SliverToBoxAdapter(
          child: (appStore.isFirstHomePageView)
              ? SlideTransition(
                  position: headerAnimation,
                  child: layout,
                )
              : layout),
    );
  }

  SliverToBoxAdapter _createHorizontaAnimelList(ApplicationStore appStore,
      {required List<AnimeItem> data,
      required double width,
      String? tag,
      required ScrollController controller}) {
    final listWidget = ListView.builder(
      controller: controller,
      itemBuilder: (context, index) {
        var anime = data[index];
        var heroTag = '${anime.id}$tag';

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
          child: ItemView(
            tooltip: anime.title,
            width: width,
            height: width * 1.4,
            imageUrl: anime.imageUrl,
            imageHeroTag: heroTag,
            onTap: () =>
                _openAnimeDetailsPage(context, anime, heroTag, appStore),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      physics: BouncingScrollPhysics(),
    );

    return SliverToBoxAdapter(
      child: Container(
          height: width * 1.4,
          child: (appStore.isFirstHomePageView)
              ? SlideTransition(
                  position: carouselAnimation,
                  child: listWidget,
                )
              : listWidget),
    );
  }

  SliverToBoxAdapter _createHorizontaCustomAnimelList(ApplicationStore appStore,
          {required double width,
          String? tag,
          required ScrollController controller}) =>
      SliverToBoxAdapter(
        child: Container(
          height: width * 1.4,
          child: Observer(
            builder: (_) {
              var data = appStore.myAnimeMap.values.toList();
              return ListView.builder(
                controller: controller,
                itemBuilder: (context, index) {
                  var anime = data[index];
                  var heroTag = '${anime.id}$tag';

                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                    child: ItemView(
                      width: width,
                      tooltip: anime.title,
                      height: width * 1.4,
                      imageUrl: anime.imageUrl,
                      imageHeroTag: heroTag,
                      onTap: () => _openAnimeDetailsPage(
                          context, anime, heroTag, appStore),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                physics: BouncingScrollPhysics(),
              );
            },
          ),
        ),
      );

  SliverToBoxAdapter _createHorizontalGenreList(
          {required List<String> data,
          required double width,
          required ScrollController controller}) =>
      SliverToBoxAdapter(
        child: Container(
          height: width * .9,
          child: Observer(
            builder: (context) {
              return ListView.builder(
                controller: controller,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
                    child: ItemView(
                      width: width * 1.3,
                      height: width * .9,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            data[index],
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                          ))
                        ],
                      ),
                      backgroundColor: _randomColor.randomColor(
                        colorHue: ColorHue.multiple(
                          colorHues: [
                            ColorHue.blue,
                          ],
                        ),
                        colorBrightness: ColorBrightness.dark,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    GenreAnimePage(genreName: data[index])));
                      },
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                physics: BouncingScrollPhysics(),
              );
            },
          ),
        ),
      );

  SliverToBoxAdapter _createHorizontalEpisodeList(BuildContext context,
          {required List<EpisodeItem> data, required double width}) =>
      SliverToBoxAdapter(
        child: Container(
          height: width + 24,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
                child: EpisodeItemView(
                  width: width * 1.3,
                  height: width * .9,
                  imageUrl: data[index].imageUrl,
                  title: data[index].title,
                  onTap: () => _playEpisode(context, data[index].id),
                ),
              );
            },
            itemCount: data.length ~/ 8,
          ),
        ),
      );

  void _openLatestEpisodePage(BuildContext context) => Navigator.push(context,
      CupertinoPageRoute(builder: (context) => RecentEpisodeListPage()));

  void _openAnimeDetailsPage(BuildContext context, AnimeItem anime,
          String heroTag, ApplicationStore appStore) =>
      Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Provider<AnimeDetailsStore>(
              create: (_) => AnimeDetailsStore(
                appStore,
                anime,
                getIt(),
                getIt(),
              ),
              child: AnimeDetailsScreen(
                heroTag: heroTag,
              ),
            ),
          ));

  Widget _createDayReleaseCarousel(
          {required BuildContext context,
          required ApplicationStore appStore,
          required double width,
          required double height}) =>
      Observer(builder: (_) {
        return Carousel(
          showIndicator: true,
          autoplay: false,
          animationCurve: Curves.easeIn,
          boxFit: BoxFit.fill,
          dotSize: 6.0,
          overlayShadow: true,
          images: List.generate(
              (appStore.dayReleaseList.length >= 12)
                  ? 12
                  : appStore.dayReleaseList.length, (index) {
            var heroTag =
                '${appStore.dayReleaseList[index].id}$HERO_TAG_CAROUSEL';
            return ItemView(
              borderRadius: .0,
              tooltip: appStore.dayReleaseList[index].title,
              imageUrl: appStore.dayReleaseList[index].imageUrl,
              width: width,
              imageHeroTag: heroTag,
              height: height,
              onTap: () => _openAnimeDetailsPage(
                  context, appStore.dayReleaseList[index], heroTag, appStore),
            );
          }),
        );
      });

  void _openAnimeItemGridPage(
      BuildContext context, List<AnimeItem> data, String title, String heroTag,
      {List<Widget>? actions}) {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => DefaultAnimeItemGridPage(
            title: title,
            gridItems: data,
            heroTag: heroTag,
            actions: actions,
          ),
        ));
  }

  void _playEpisode(BuildContext context, String episodeId) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => VideoPlayerScreen(
                  episodeId: episodeId,
                )));
  }
}
