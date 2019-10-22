import 'package:anime_app/logic/ApplicationBloc.dart';
import 'package:anime_app/ui/component/InfoWidget.dart';
import 'package:anime_app/ui/pages/VideoPlayerScreen.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:provider/provider.dart';
import 'package:anime_app/logic/Constants.dart';

class AnimeDetailsScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String heroTag;
  static final _defaultSectionStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  const AnimeDetailsScreen({Key key, this.title, this.heroTag, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<ApplicationBloc>(context);
    final future = bloc.getAnimeDetails(heroTag);

    final appBar = SliverAppBar(
      floating: false,
      pinned: false,
      snap: false,
      expandedHeight: 350,
      backgroundColor: IMAGE_BACKGROUND_COLOR,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: this.heroTag ?? UniqueKey().toString(),
          child: Image(
              fit: BoxFit.fill,
              image: AdvancedNetworkImage(
                imageUrl,
                useDiskCache: true,
                retryLimit: 5,
              )
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          appBar,

          SliverToBoxAdapter(
              child: FutureBuilder<AnimeDetails>(
                future: future,
                builder: (context, snapshot) {

                  if (snapshot.hasError)
                    return InfoWidget(
                      size: 250,
                      icon: Icons.clear,
                      iconColor: ERROR_COLOR,
                      textColor: ERROR_COLOR,
                      text: 'Não há dados...',
                    );

              if (!snapshot.hasData)
                return Container(
                  height: 200,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[ CircularProgressIndicator(), ],
                  ),
                );

              if (snapshot.hasError)
                return Center(child: Text('Erro'));

              var data  = snapshot.data;

              return Column(
                children: <Widget>[
                  buildDetailsSection(data),
                  buildResumeSection(data.resume),

                ],
              );
            },
          )),

          FutureBuilder<AnimeDetails>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return SliverList(delegate: SliverChildBuilderDelegate(
                    (context, index) {

                      return ListTile(
                        leading: Icon(Icons.play_circle_filled, color: Colors.black,),
                        title: Text(snapshot.data.episodes[index].title),
                        onTap: () async {
                          Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerScreen(
                                  episodeId: snapshot.data.episodes[index].id,
                                )
                              )
                          );
                        },
                      );
                    },
                    childCount: snapshot.data.episodes.length,
                  ));

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
