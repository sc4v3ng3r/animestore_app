import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/pages/AnimeDetailsScreen.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  static const _UPDATE_TAG = 'UPDATE';
  static const _RELEASE_TAG = 'RELEASE';
  static const _CAROUSEL_TAG = 'CAROUSEL';

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
        primary: true,
        centerTitle: false,
        backgroundColor: Colors.white.withOpacity(.3),
        flexibleSpace: FlexibleSpaceBar(
            background: _createDayReleaseCarousel(
              context: context,
              width: size.width,
              height: expandedHeight,
              appStore: appStore,
            )
        )
    );

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        appBar,

        _createHeaderSection(
            leading: Icon(Icons.star, ),
            header: 'Top Animes'
        ),

        _createHorizontaAnimelList(
          data:appStore.topAnimeList,
          width: size.width * .42,
          tag: _UPDATE_TAG,
        ),

        _createHeaderSection(
            leading: Icon(Icons.update),
            header: 'Mais recentes'
        ),

        _createHorizontaAnimelList(
          data:appStore.mostRecentAnimeList,
          width: size.width * .42,
          tag: _RELEASE_TAG,
        ),
      ],
    );
  }



  SliverPadding _createHeaderSection({Widget leading,  String header}) =>
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        sliver: SliverToBoxAdapter(
          child: Row(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: (leading == null) ? .0 : 8.0),
                child: leading,
              ),
              Text(header, style: TextStyle(
                fontSize: 18,),
              ),
            ],
          ),
          ),
        );

  SliverToBoxAdapter _createHorizontaAnimelList({
    List<AnimeItem>  data, double width, String tag}) =>
      SliverToBoxAdapter(
        child: Container(
          height: width * 1.4,
          child: Observer(
            builder: (context){
              return ListView.builder(
                itemBuilder: (context, index) {
                  print('Build the list box');
                  var anime = data[index];
                  var heroTag = '${anime.id}$tag';

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                    child: ItemView(
                      width: width,
                      height: width * 1.4,
                      imageUrl: anime.imageUrl,
                      heroTag: heroTag,
                      onTap: () => _openAnimeDetailsPage(context, anime, heroTag),
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


    void _openAnimeDetailsPage(BuildContext context, AnimeItem anime, String heroTag) =>
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => AnimeDetailsScreen(
                  anime.id,
                  title: anime.title,
                  imageUrl: anime.imageUrl,
                  heroTag: heroTag,
                )
            )
        );

    Widget _createDayReleaseCarousel({BuildContext context, ApplicationStore appStore, double width, height}) =>
        Carousel(
          showIndicator: true,
          autoplay: true,
          autoplayDuration: Duration(seconds: 6),
          animationCurve: Curves.easeIn,
          boxFit: BoxFit.fill,
          dotSize: 6.0,
          overlayShadow: true,

          images: List.generate(
              appStore.dayReleaseList.length,
                  (index){
                var heroTag = '${appStore.dayReleaseList[index].id}$_CAROUSEL_TAG';
                return ItemView(
                  borderRadius: .0,

                  imageUrl: appStore.dayReleaseList[index].imageUrl,
                  width: width,
                  heroTag: heroTag,
                  height: height,
                  onTap: () => _openAnimeDetailsPage(
                      context,
                      appStore.dayReleaseList[index], heroTag),
                );
              }
          ),
        );
}
