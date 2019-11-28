import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/video_player_store/VideoPlayerStore.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String episodeId;

  const VideoPlayerScreen({Key key, this.episodeId})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}


class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  static const _DEFAULT_ASPECT_RATIO = 3/2;

  ApplicationStore appStore;
  VideoPlayerStore videoPlayerStore;
  VideoPlayerController _playerController;
  ChewieController _chewieController;

  @override
  void initState() {

    SystemChrome.setPreferredOrientations( DeviceOrientation.values );

    super.initState();
    appStore = Provider.of<ApplicationStore>(context, listen: false);
    videoPlayerStore = VideoPlayerStore(appStore);
    videoPlayerStore.loadEpisodeDetails(widget.episodeId);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        print('OnWillPop');
        if (videoPlayerStore.episodeLoadingStatus == EpisodeLoading.LOADING) {
          videoPlayerStore.cancelEpisodeLoading();
        }

        else if (_chewieController.isFullScreen) {
          _chewieController.exitFullScreen();
          return true;
        }

        await SystemChrome.setPreferredOrientations( [DeviceOrientation.portraitUp, ] );
        return true;
      },

      child: Scaffold(
        backgroundColor: Colors.black,
        body: Observer(
          builder: (context){
            if(videoPlayerStore.episodeLoadingStatus == EpisodeLoading.LOADING)
              return Center(
                child: CircularProgressIndicator(),
              );

            if (videoPlayerStore.episodeLoadingStatus == EpisodeLoading.ERROR)
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Icon(Icons.error, color: Colors.red, size: 82,)),
                  Container(height: 10,),
                  Text(
                    'Vídeo Indisponível..',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),),

                  RaisedButton(
                    child: Text('Voltar'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              );

            if (videoPlayerStore.episodeLoadingStatus == EpisodeLoading.CANCELED)
              return Container();

            if (videoPlayerStore.episodeLoadingStatus == EpisodeLoading.DONE){
              _playerController ??= _createPlayerController(
                  videoPlayerStore.currentEpisode.streamingUrl, );
              _chewieController ??= _createChewieController();

            }

            return Chewie( controller: _chewieController, );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _clearControllers();
    super.dispose();
  }

  void playNext(){}

  void playPrevious(){}

  VideoPlayerController _createPlayerController(String streamUrl) =>
      VideoPlayerController.network(streamUrl,
          httpHeaders: {'Referer': videoPlayerStore.currentEpisode.referer} );

  ChewieController _createChewieController() =>
      ChewieController(
        videoPlayerController: _playerController,
        aspectRatio: _DEFAULT_ASPECT_RATIO,
        allowFullScreen: true,
        fullScreenByDefault: false,
        autoPlay: true,
        looping: false,
        showControls: true,
        allowedScreenSleep: false,
        allowMuting: true,
        showControlsOnInitialize: true,
      );

  void _clearControllers(){
    _chewieController?.dispose();
    _playerController?.dispose();
    _chewieController = null;
    _playerController = null;
  }

}