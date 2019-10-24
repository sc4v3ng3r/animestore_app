import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:mobx/mobx.dart';

part 'VideoPlayerStore.g.dart';

class VideoPlayerStore = _VideoPlayerStore with _$VideoPlayerStore;

enum EpisodeLoading {LOADING, DONE, CANCELED, ERROR}
abstract class _VideoPlayerStore with Store {

  final ApplicationStore appStore;

  _VideoPlayerStore(this.appStore);

  @observable
  EpisodeLoading episodeLoadingStatus;

  EpisodeDetails currentEpisode;

  void cancelEpisodeLoading() =>
      setEpisodeLoadingStatus(EpisodeLoading.ERROR);

  @action
  setEpisodeLoadingStatus(EpisodeLoading status)
    => episodeLoadingStatus = status;


  void loadEpisodeDetails(String episodeId) async {
    if (episodeLoadingStatus == EpisodeLoading.LOADING)
      return;

    try {
      setEpisodeLoadingStatus(EpisodeLoading.LOADING);

      currentEpisode = await appStore.api.getEpisodeDetails(episodeId,
          timeout: 10000);

      if (episodeLoadingStatus == EpisodeLoading.CANCELED) {
        currentEpisode = null;
        return;
      }

      if (episodeLoadingStatus != EpisodeLoading.ERROR)
        setEpisodeLoadingStatus(EpisodeLoading.DONE);

    }
    on CrawlerApiException catch(ex){
      setEpisodeLoadingStatus(EpisodeLoading.ERROR);
      currentEpisode = null;
    }
  }

}