import 'package:anime_app/generated/l10n.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/app_bar/AnimeStoreHeroAppBar.dart';
import 'package:anime_app/ui/component/EpisodeItemView.dart';
import 'package:anime_app/ui/pages/VideoPlayerScreen.dart';
import 'package:anime_app/ui/utils/HeroTags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//
//return ItemView(
//width: width,
//height: height,
//child: Row(
//mainAxisSize: MainAxisSize.max,
//children: <Widget>[
//Expanded(
//child: Text(applicationStore.genreList[index],
//textAlign: TextAlign.center,
//maxLines: 2,
//style: TextStyle(
//color: Colors.white,
//fontWeight: FontWeight.w600,
//fontSize: 25,
//),
//)
//)
//],
//),
//backgroundColor: _randomColor.randomColor(
//colorHue: ColorHue.multiple(
//colorHues: [ ColorHue.orange, ColorHue.blue],
//),
//colorBrightness: ColorBrightness.primary,
//),
//onTap: () {},
//);
class RecentEpisodeListPage extends StatelessWidget {
  const RecentEpisodeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var applicationStore = Provider.of<ApplicationStore>(context);
    final locale = S.of(context);
    var data = applicationStore.latestEpisodes;

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          AnimeStoreHeroAppBar(
            title: locale.latestEpisodes,
            heroTag: HeroTags.TAG_LATEST_EPISODES,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return EpisodeItemView(
                    width: size.width,
                    height: size.width / 1.5,
                    title: data[index].title,
                    imageUrl: data[index].imageUrl,
                    fontSize: 18,
                    fontColor: Colors.white,
                    onTap: () => _playEpisode(context, data[index].id),
                  );
                },
                childCount: data.length,
              ),
            ),
          ),
        ],
      ),
    );
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
