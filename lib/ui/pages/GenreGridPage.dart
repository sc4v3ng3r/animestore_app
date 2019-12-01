import 'package:anime_app/i18n/AnimeStoreLocalization.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/AnimeStoreAppBar.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/component/SliverGridViewWidget.dart';
import 'package:anime_app/ui/pages/GenreAnimePage.dart';
import 'package:anime_app/ui/pages/HeroTags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class GenreGridPage extends StatelessWidget {
  final RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var applicationStore = Provider.of<ApplicationStore>(context);

    var width = size.width * 1.3;
    var height =  size.width * .9;

    final locale = AnimeStoreLocalization.of(context);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[

          AnimeStoreAppBar(
            title: locale.exploreGenres,
            heroTag: HeroTags.TAG_EXPLORE_GENRES,
          ),

          SliverGridItemView(
            childAspectRatio: (width / height),
            delegate: SliverChildBuilderDelegate(
                (context, index){
                  return ItemView(
                    width: width,
                    height: height,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: Text(applicationStore.genreList[index],
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
                        colorHues: [ ColorHue.blue],
                      ),
                      colorBrightness: ColorBrightness.dark,
                    ),
                    onTap: () {
                      Navigator.push(context,
                        CupertinoPageRoute(builder: (context)
                          => GenreAnimePage(genreName: applicationStore.genreList[index])
                        ),
                      );
                    },
                  );
                },
              childCount: applicationStore.genreList.length,
            ),
          ),
        ],
      ),
    );
  }
}
