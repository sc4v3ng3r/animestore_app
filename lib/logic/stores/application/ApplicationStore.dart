import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:mobx/mobx.dart';

part 'ApplicationStore.g.dart';

class ApplicationStore = _ApplicationStore with _$ApplicationStore;

abstract class _ApplicationStore with Store {

  final AniTubeApi api = AniTubeApi();
  static const DEFAULT_PAGES_LOADING = 4;
  static const TIMEOUT = 10000;

  @observable
  ObservableList<AnimeItem> mainAnimeList = ObservableList();

  @observable
  ObservableList<AnimeItem> mostRecentAnimeList = ObservableList();

  @observable
  ObservableList<AnimeItem> topAnimeList = ObservableList();

  @observable
  ObservableList<AnimeItem> dayReleaseList = ObservableList();

  /// counter of main animes list pages.
  int mainAnimesPageCounter = 1;
  int maxMainAnimesPageNumber = 1;

  int mainCarouselCurrentPosition = 1;

  @observable
  LoadingStatus animeListLoadingStatus = LoadingStatus.NONE;

  @observable
  AppInitStatus appInitStatus = AppInitStatus.INITIALIZING;

  @action
  setAnimeListLoadingStatus(LoadingStatus status) => animeListLoadingStatus = status;

  @action
  addAnimeItem(List<AnimeItem> data) => mainAnimeList.addAll( data );

  @action
  setAppInitialization(AppInitStatus status) => appInitStatus = status;

  @action
  setMostRecentAnimeList(List<AnimeItem> data) => mostRecentAnimeList.addAll(data);
  
  @action
  setDailyReleases( List<AnimeItem> data ) => dayReleaseList.addAll(data );

  @action
  setTopAnimeList ( List<AnimeItem> data) => topAnimeList.addAll( data );

  // init application method
  void initApp() async {
    try {
      await getHomePageInfo();

      await loadAnimeList();
      setAppInitialization(AppInitStatus.INITIALIZED);
    }

    on CrawlerApiException catch(ex){
      print(ex);
      setAppInitialization(AppInitStatus.ERROR);
    }
  }

  // This method load the main anime list and handles also the pagination.
  // We must always load main anime list data with this method.
  Future<void> loadAnimeList() async {
    if (animeListLoadingStatus == LoadingStatus.LOADING)
      return;

    var cacheList = <AnimeItem>[];

    if (mainAnimesPageCounter <= maxMainAnimesPageNumber) {
      setAnimeListLoadingStatus(LoadingStatus.LOADING);

      for (int i = 0; i < DEFAULT_PAGES_LOADING; i++) {
        try {
          var data = await api.getAnimeListPageData(
              pageNumber: mainAnimesPageCounter);

          cacheList.addAll(data.animes);

          maxMainAnimesPageNumber = int.parse(data.maxPageNumber);
          mainAnimesPageCounter++;
        }
        on CrawlerApiException catch (ex) {
          print('Fail loding page number $mainAnimesPageCounter $ex');
          mainAnimesPageCounter++;
        }
      }
    }

    addAnimeItem(cacheList);
    setAnimeListLoadingStatus(LoadingStatus.DONE);
  }

  Future<AnimeDetails> getAnimeDetails(String id, ) =>
      api.getAnimeDetails(id, timeout: TIMEOUT);

  Future<void> getHomePageInfo() async{
    var homePageData = await api.getHomePageData();
    setDailyReleases( homePageData.dayReleases );
    setMostRecentAnimeList( homePageData.mostRecentAnimes );
    setTopAnimeList( homePageData.mostShowedAnimes);

  }
}