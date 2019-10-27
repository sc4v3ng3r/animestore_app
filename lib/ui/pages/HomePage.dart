import 'package:anime_app/logic/Constants.dart';
import 'package:anime_app/logic/stores/anime_details_store/AnimeDetailsStore.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/UiUtils.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/pages/AnimeDetailsScreen.dart';
import 'package:anime_app/ui/pages/DefaultAnimeItemGridPage.dart';
import 'package:anime_app/ui/pages/GenreGridPage.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class HomePage extends StatelessWidget {

  final RandomColor _randomColor = RandomColor();

  static const _SECTION_STYLE = TextStyle(
    fontSize: 18, );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final appStore = Provider.of<ApplicationStore>(context);

    final expandedHeight = size.width * .9;

    final appBar = SliverAppBar(
        expandedHeight: expandedHeight,
        floating: false,
        elevation: 0.0,
        pinned: false,
        snap: false,
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(.3),
        //title: Text('AppBar', style: TextStyle(color: Colors.black),),
        flexibleSpace: FlexibleSpaceBar(
            background: _createDayReleaseCarousel(
              context: context,
              width: size.width,
              height: expandedHeight,
              appStore: appStore,
            )
        ),
    );

    final topAnimesHeader = _createHeaderSection(context,
      title: 'Top Animes',
      iconData: Icons.star,
      iconColor: Colors.amberAccent,
      heroTag: 'TopAnimesTag',
//      leading: Icon(, ),
//      header: 'Top Animes',
    );

    final genresHeader = _createHeaderSection(context,
      iconData:Icons.explore,
      title: 'Explorar Gêneros',
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => GenreGridPage()
          ),
        );
      },
    );

    final myListHeader = Observer(
      builder: (context) =>
      (appStore.myAnimeMap.isEmpty) ? SliverToBoxAdapter(child: Container(),)
          :
      _createHeaderSection(context,
          title: 'Minha Lista',
          iconData: Icons.live_tv,
          onTap: () =>_openAnimeItemGridPage(context, appStore.myAnimeMap.values.toList(),),
      ),
    );

    final mostRecentsHeader = _createHeaderSection(context,
      iconData: Icons.update,
      title: 'Mais recentes',
      onTap: () => _openAnimeItemGridPage(context, appStore.mostRecentAnimeList,),
    );

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        appBar,

        topAnimesHeader,

        _createHorizontaAnimelList(
          appStore,
          data:appStore.topAnimeList,
          width: size.width * .42,
          tag: HERO_TAG_UPDATE,
        ),

        mostRecentsHeader,

        _createHorizontaAnimelList(
          appStore,
          data:appStore.mostRecentAnimeList,
          width: size.width * .42,
          tag: HERO_TAG_RELEASE,
        ),


        genresHeader,

        _createHorizontalGenreList(
          width: size.width * .42,
          data: appStore.genreList,
        ),


        myListHeader,

        Observer(
          builder: (context) =>
          (appStore.myAnimeMap.isEmpty) ? SliverToBoxAdapter(child: Container(),)
              :
          _createHorizontaCustomAnimelList(
            appStore,
            width: size.width * .42,
            tag: HERO_TAG_MY_LIST,
          ),
        ),

      ],
    );
  }

  SliverPadding _createHeaderSection(BuildContext context,{
    IconData iconData,
    Color iconColor,
    String title,

    Widget leading,
    String header,
    String heroTag,
    Function onTap}) =>
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        sliver: SliverToBoxAdapter(
          child: GestureDetector(
            child: UiUtils.createAppBarTitleWidget(
              iconData: iconData,
              iconColor:iconColor,
              title: title,
              heroTag: heroTag,
              style: _SECTION_STYLE,
            ),
            onTap: onTap,
          ),
        ),
      );

  SliverToBoxAdapter _createHorizontaAnimelList(ApplicationStore appStore, {
    List<AnimeItem>  data, double width, String tag,}) =>
      SliverToBoxAdapter(
        child: Container(
          height: width * 1.4,
          child: ListView.builder(
                itemBuilder: (context, index) {
                  var anime = data[index];
                  var heroTag = '${anime.id}$tag';

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                    child: ItemView(
                      width: width,
                      height: width * 1.4,
                      imageUrl: anime.imageUrl,
                      imageHeroTag: heroTag,
                      onTap: () => _openAnimeDetailsPage(context, anime, heroTag, appStore),
                    ),
                  );
                },

                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                physics: BouncingScrollPhysics(),
              ),
        ),
      );

  SliverToBoxAdapter _createHorizontaCustomAnimelList(ApplicationStore appStore, {
    double width, String tag,}) =>
      SliverToBoxAdapter(
        child: Container(
          height: width * 1.4,
          child: Observer(
            builder: (_) {
              var data = appStore.myAnimeMap.values.toList();
              return ListView.builder(
                itemBuilder: (context, index) {
                  var anime = data[index];
                  var heroTag = '${anime.id}$tag';

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                    child: ItemView(
                      width: width,
                      height: width * 1.4,
                      imageUrl: anime.imageUrl,
                      imageHeroTag: heroTag,
                      onTap: () => _openAnimeDetailsPage(context, anime, heroTag, appStore),
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

  SliverToBoxAdapter _createHorizontalGenreList( {
    List<String>  data, double width, String tag}) =>
      SliverToBoxAdapter(
        child: Container(
            height: width * .9,
            child: Observer(
              builder: (context){
                return ListView.builder(
                  itemBuilder: (context, index) {

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
                      child: ItemView(
                        width: width * 1.3,
                        height: width * .9,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: Text(data[index],
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                )
                            )
                          ],
                        ),
                        backgroundColor: _randomColor.randomColor(
                          colorHue: ColorHue.multiple(
                            colorHues: [ ColorHue.orange, ColorHue.blue],
                          ),
                          colorBrightness: ColorBrightness.primary,
                        ),
                        onTap: () {},
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

    void _openAnimeDetailsPage(BuildContext context, AnimeItem anime, String heroTag,
        ApplicationStore appStore) =>
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => Provider<AnimeDetailsStore>(
                  builder: (_) => AnimeDetailsStore(appStore, anime),
                  child: AnimeDetailsScreen(heroTag: heroTag,),
                ),
            )
        );

    Widget _createDayReleaseCarousel({BuildContext context, ApplicationStore appStore, double width, height}) =>
        Carousel(
          showIndicator: true,
          autoplay: false,
          animationCurve: Curves.easeIn,
          boxFit: BoxFit.fill,
          dotSize: 6.0,
          overlayShadow: true,

          images: List.generate(
              appStore.dayReleaseList.length,
                  (index){
                var heroTag = '${appStore.dayReleaseList[index].id}$HER_TAG_CAROUSEL';
                return ItemView(
                  borderRadius: .0,
                  imageUrl: appStore.dayReleaseList[index].imageUrl,
                  width: width,
                  imageHeroTag: heroTag,
                  height: height,
                  onTap: () => _openAnimeDetailsPage(
                      context,
                      appStore.dayReleaseList[index], heroTag, appStore),
                );
              }
          ),
        );

  void _openAnimeItemGridPage(BuildContext context, List<AnimeItem> data,) {
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => DefaultAnimeItemGridPage(
          gridItems: data,
        )
    ));
  }
}

