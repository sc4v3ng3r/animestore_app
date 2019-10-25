import 'dart:ui';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/anime_details_store/AnimeDetailsStore.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/pages/VideoPlayerScreen.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AnimeDetailsScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String heroTag;
  final String animeId;

  const AnimeDetailsScreen(this.animeId, {Key key, this.title, this.heroTag, this.imageUrl})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimeDetailsScreen();

}

class _AnimeDetailsScreen extends State<AnimeDetailsScreen>{
  ApplicationStore applicationStore;
  AnimeDetailsStore detailsStore;

  static final _defaultSectionStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  @override
  void initState() {
    super.initState();
    applicationStore = Provider.of<ApplicationStore>(context, listen: false);
    detailsStore = AnimeDetailsStore(applicationStore);
    detailsStore.loadAnimeDetails(widget.animeId);
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final expandedHeight = size.width * .9;

    final provider = AdvancedNetworkImage(
      widget.imageUrl,
      useDiskCache: true,
      retryLimit: 5,
    );

    final image = Image(
      fit: BoxFit.fill,
      image: provider,
    );

    final appBar = Observer(
      builder: (_) => SliverAppBar(
        floating: false,
        pinned: false,
        snap: false,
        expandedHeight: expandedHeight,
        backgroundColor: detailsStore.backgroundColor,
        flexibleSpace: FlexibleSpaceBar(
          background: Hero(
            tag: widget.heroTag ?? UniqueKey().toString(),
            child: image,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          appBar,

          SliverToBoxAdapter(
              child: Observer(
                builder: (context){

                  if (detailsStore.loadingStatus == LoadingStatus.ERROR)
                    return Center(child: Text('Erro'));


                  if (detailsStore.loadingStatus == LoadingStatus.LOADING)
                    return Container(
                      height: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[ CircularProgressIndicator(), ],
                      ),
                    );

                  return Column(
                    children: <Widget>[
                      buildDetailsSection(detailsStore.animeDetails),
                      buildResumeSection(detailsStore.animeDetails.resume),

                    ],
                  );
                },
              )),

          Observer(
              builder: (context) {
                if (detailsStore.loadingStatus == LoadingStatus.DONE) {

                  if (detailsStore.animeDetails.episodes.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.do_not_disturb_alt, size: 52,),
                            Text('Episódios indisponíveis...'),
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverList(delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return ListTile(
                        leading: Icon(Icons.play_circle_filled, color: Colors
                            .black,),
                        title: Text(detailsStore.animeDetails.episodes[index].title),
                        onTap: () async {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VideoPlayerScreen(
                                        episodeId: detailsStore.animeDetails.episodes[index].id,
                                      )
                              )
                          );
                        },
                      );
                    },
                    childCount: detailsStore.animeDetails.episodes.length,
                  ));
                }
                else
                  return SliverToBoxAdapter(
                    child: Container(),
                  );
              }),
        ],
      ),
    );
  }

  Widget buildDetailsSection(AnimeDetails data) => ExpansionTile(
    title: Text('Detalhes'),
    children: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              margin: EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      data.title,
                      style: _defaultSectionStyle,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
            _buildInfoRow('Genero: ', data.genre),
            _buildInfoRow('Estudio: ', data.studio),
            _buildInfoRow('Autor: ', data.author),
            _buildInfoRow('Diretor: ', data.director),
            _buildInfoRow('Ano: ', data.year),
            _buildInfoRow('Episodios: ', data.episodesNumber),
          ],
        ),
      )
    ],
  );

  Widget buildResumeSection(String resume) =>
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        child: ExpansionTile(
          title: Text('Sinopse',),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Text(resume ?? '----',
                        maxLines: 24,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            letterSpacing: .2
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],

        ),
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
}