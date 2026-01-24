import 'package:anime_app/logic/Constants.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:mobx/mobx.dart';
import 'package:video_player/video_player.dart';
import 'dart:async' as NativeAsync;

import '../../../src/core/domain/models/animestore_video_detail.model.dart';
import '../../../src/core/domain/models/content/animestore_content_settings.model.dart';
import '../../../src/core/domain/models/http/animestore_http_request.model.dart';
import '../../../src/core/external/global_declarations.dart';
import '../../../src/features/anitube/external/datasource/anitube_episode_video_datasource.impl.dart';

part 'VideoPlayerStore.g.dart';

class VideoPlayerStore = _VideoPlayerStore with _$VideoPlayerStore;

enum EpisodeStatus {
  DOWNLOADING,
  DOWNLOADING_DONE,
  CANCELED,
  ERROR,
  BUFFERING,
  READY,
  NONE
}

abstract class _VideoPlayerStore with Store {
  final ApplicationStore appStore;

  _VideoPlayerStore(this.appStore);

  @observable
  EpisodeStatus episodeLoadingStatus = EpisodeStatus.NONE;

  late AnimestoreVideoDetails? currentEpisode;

  VideoPlayerController? controller;

  @observable
  bool isPlaying = false;

  @observable
  Duration currentPosition = Duration(milliseconds: 0);

  void cancelEpisodeLoading() =>
      setEpisodeLoadingStatus(EpisodeStatus.CANCELED);

  @action
  setEpisodeLoadingStatus(EpisodeStatus status) {
    print('Inside the action $status');
    episodeLoadingStatus = status;
  }

  @action
  void _setPlayingStatus(bool status) => isPlaying = status;

  @action
  void _setCurrentPosition(Duration duration) => currentPosition = duration;

  void playOrPause() {
    if (controller == null) return;

    controller!.value.isPlaying ? controller!.pause() : controller!.play();

    _setPlayingStatus(controller!.value.isPlaying);
  }

  void loadEpisodeDetails(String episodeUri) async {
    if (episodeLoadingStatus == EpisodeStatus.DOWNLOADING) return;

    try {
      final uri = Uri.parse(episodeUri);
      print('Loading episode ${uri.path}');
      setEpisodeLoadingStatus(EpisodeStatus.DOWNLOADING);

      final feat = appStore.appSettings.features['anime-video-details'];
      if (feat != null) {
        final dataSource = getIt<AnitubeEpisodeVideoDatasourceImpl>();
        final httpRequest = AnimeStoreRequestParametrizedBuilder.build(
            setting: feat.apiSettings, pathParams: [uri.path]);

        currentEpisode = await dataSource.exec(AnimeStoreContentSettingsImpl(
            declaration: feat.parserDeclaration, request: httpRequest));

        print('Video: ${currentEpisode?.streamingUrl}');
        print('Anime: ${currentEpisode?.animeId}');
      }
      if (episodeLoadingStatus == EpisodeStatus.CANCELED) {
        currentEpisode = null;
        return;
      }

      if (currentEpisode != null &&
          episodeLoadingStatus != EpisodeStatus.ERROR) {
        // must be buffering...
        setEpisodeLoadingStatus(EpisodeStatus.DOWNLOADING_DONE);
        controller?.dispose();
        print('The url will be ${currentEpisode!.streamingUrl}');
        controller = VideoPlayerController.networkUrl(
          Uri.parse(currentEpisode!.streamingUrl),
          httpHeaders: {
            'Referer': currentEpisode!.referer,
            'User-Agent': 'Mozilla/5.0',
          },
        );

        await controller!.initialize().timeout(
              Duration(seconds: VIDEO_INIT_TIMEOUT),
            );

        controller!.addListener(_controllerListener);
        setEpisodeLoadingStatus(EpisodeStatus.READY);

        playOrPause();

        appStore.addWatchedEpisode(
          episodeUri,
          episodeTitle: currentEpisode!.title,
          viewedAt: DateTime.now().millisecond,
        );
      }
    }
    // handling timeout exception
    on NativeAsync.TimeoutException catch (ex) {
      print(ex);
      _handleVideoLoadingException();
    } catch (ex) {
      print(ex);
      _handleVideoLoadingException();
    }
  }

  void _handleVideoLoadingException() {
    setEpisodeLoadingStatus(EpisodeStatus.ERROR);
    currentEpisode = null;
  }

  void _controllerListener() {
    _setCurrentPosition(controller!.value.position);

    // if is the end of the reproduction
    if (controller!.value.position.inMilliseconds >=
            controller!.value.duration.inMilliseconds &&
        currentEpisode!.nextEpisodeId.isNotEmpty) nextEpisode();
  }

  void nextEpisode() async {
    _prepareControllerToAnotherEpisode();
    loadEpisodeDetails(currentEpisode!.nextEpisodeId);
  }

  void previousEpisode() async {
    _prepareControllerToAnotherEpisode();
    loadEpisodeDetails(currentEpisode!.previousEpisodeId);
  }

  void _prepareControllerToAnotherEpisode() {
    if (controller!.value.isPlaying) controller!.pause();

    controller!.removeListener(_controllerListener);
  }

  void dispose() {
    controller?.removeListener(_controllerListener);
    controller?.dispose();
  }

  void seekTo(int seconds) =>
      controller!.seekTo(Duration(seconds: (seconds < 0) ? 0 : seconds));
}
