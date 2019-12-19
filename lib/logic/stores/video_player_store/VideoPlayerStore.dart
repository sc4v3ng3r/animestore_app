import 'dart:async';

import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:mobx/mobx.dart';
import 'package:video_player/video_player.dart';

part 'VideoPlayerStore.g.dart';

class VideoPlayerStore = _VideoPlayerStore with _$VideoPlayerStore;

enum EpisodeStatus {DOWNLOADING, DOWNLOADING_DONE, CANCELED, ERROR, BUFFERING, READY}

abstract class _VideoPlayerStore with Store {

  final ApplicationStore appStore;

  _VideoPlayerStore(this.appStore);

  @observable
  EpisodeStatus episodeLoadingStatus;

  EpisodeDetails currentEpisode;

  VideoPlayerController controller;

  @observable
  bool isPlaying = false;

  @observable
  Duration currentPosition = Duration(milliseconds: 0);
  

  void cancelEpisodeLoading() =>
      setEpisodeLoadingStatus(EpisodeStatus.CANCELED);

  @action
  setEpisodeLoadingStatus(EpisodeStatus status){
   print('Inside the action $status');
   episodeLoadingStatus = status;
  }

  @action void _setPlayingStatus(bool status) =>
    isPlaying = status;

  @action void _setCurrentPosition(Duration duration) => currentPosition = duration;

  void playOrPause() {
    if (controller == null)
    return;

    controller.value.isPlaying ? 
      controller.pause() :
      controller.play();

    _setPlayingStatus(controller.value.isPlaying);
  }
  void loadEpisodeDetails(String episodeId) async {
    if (episodeLoadingStatus == EpisodeStatus.DOWNLOADING)
      return;

    try {
      setEpisodeLoadingStatus(EpisodeStatus.DOWNLOADING);

      currentEpisode = await appStore.api.getEpisodeDetails(episodeId,
          timeout: 10000);

      if (episodeLoadingStatus == EpisodeStatus.CANCELED) {
        currentEpisode = null;
        return;
      }

      if (episodeLoadingStatus != EpisodeStatus.ERROR){
        setEpisodeLoadingStatus(EpisodeStatus.DOWNLOADING_DONE);
        controller = VideoPlayerController.network(currentEpisode.streamingUrl,
          httpHeaders: {'Referer': currentEpisode.referer} );
        
        controller.initialize().then( 
          (_){
            controller.addListener( _controllerListener );
            setEpisodeLoadingStatus(EpisodeStatus.READY);
          } 
          );     
      }

    }
    on CrawlerApiException catch(ex){
      setEpisodeLoadingStatus(EpisodeStatus.ERROR);
      currentEpisode = null;
    }
  }

  void _controllerListener(){
    print('The absolute position is ${controller.value.absolutePosition}');
    _setCurrentPosition( controller.value.position );
  }

  @override
  void dispose() {
    controller?.removeListener( _controllerListener );
    
    controller?.dispose();
    super.dispose();
  }
}