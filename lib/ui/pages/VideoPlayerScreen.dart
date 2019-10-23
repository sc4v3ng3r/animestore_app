import 'dart:async';

import 'package:anime_app/logic/ApplicationBloc.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
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

  VideoPlayerController _playerController;
  ChewieController _chewieController;
  ApplicationBloc _bloc;

  Future<void> _initializeVideoPlayerFuture;
  EpisodeDetails _episodeDetails;
  Stream<String> episodeSubscription;

  Future<void> _initEpisode( )  async {
    try {
     _episodeDetails = await _bloc.getEpisodeDetails( widget.episodeId, );

      _playerController = VideoPlayerController.network( _episodeDetails.streamingUrl );

      _chewieController = ChewieController(
        videoPlayerController: _playerController,
        aspectRatio: _DEFAULT_ASPECT_RATIO,
        autoPlay: true,
        allowFullScreen: true,
        looping: false,
        showControls: true,
        allowedScreenSleep: false,
        allowMuting: true,
        fullScreenByDefault: false,
        showControlsOnInitialize: true,
      );
      return Future.value();
    }

    catch( ex ){

    }

    return Future.error('Error carregando episodio.');
  }

  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<ApplicationBloc>(context, listen: false);
     _initializeVideoPlayerFuture = _initEpisode();

  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        //_playerController?.pause();
        return true;
      },

      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<void>(
          future: _initializeVideoPlayerFuture,

          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done){

              if (snapshot.hasError)
                return Center(child: Text('Erro'),);

              return Chewie(controller: _chewieController);
            }
            return Center(child: CircularProgressIndicator(),);

          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _playerController?.dispose();
    print('disposing video player');
    super.dispose();
  }

  void playNext(){}

  void playPrevious(){}
}