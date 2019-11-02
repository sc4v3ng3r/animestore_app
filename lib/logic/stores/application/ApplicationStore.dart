import 'package:anime_app/database/DatabaseProvider.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:mobx/mobx.dart';

part 'ApplicationStore.g.dart';

class ApplicationStore = _ApplicationStore with _$ApplicationStore;

abstract class _ApplicationStore with Store {

  final AniTubeApi api = AniTubeApi();
  final DatabaseProvider databaseProvider = DatabaseProvider();
  static const DEFAULT_PAGES_LOADING = 4;
  static const TIMEOUT = 10000;

  double topAnimeOffset =0, myListOffset =0,
      mainAnimeListOffset =0, mostRecentOffset =0, genreListOffset =.0;


  @observable
  ObservableList<AnimeItem> mainAnimeList = ObservableList();

  @observable
  ObservableList<AnimeItem> mostRecentAnimeList = ObservableList();

  @observable
  ObservableList<AnimeItem> topAnimeList = ObservableList();

  @observable
  ObservableList<AnimeItem> dayReleaseList = ObservableList();

  @observable
  ObservableList<String> genreList = ObservableList();

  @observable
  ObservableMap<String, AnimeItem> myAnimeMap = ObservableMap();

  @observable
  ObservableMap<String, List<String>> watchedEpisodeMap = ObservableMap();

  @observable
  ObservableList<EpisodeItem> latestEpisodes = ObservableList();

  /// counter of main animes list pages.
  int mainAnimesPageCounter = 1;
  int maxMainAnimesPageNumber = 1;
  int mainCarouselCurrentPosition = 1;

  @observable
  LoadingStatus animeListLoadingStatus = LoadingStatus.NONE;

  @observable
  AppInitStatus appInitStatus = AppInitStatus.INITIALIZING;

  @action
  setWatchedEpisodeMap(Map<String, List<String>> data)
    => watchedEpisodeMap = ObservableMap.of(data);

  @action
  addWatchedEpisode(String animeId, String episodeId) {
    if (!_isInMyList(animeId))
      return;

    if (watchedEpisodeMap[animeId] == null)
      watchedEpisodeMap.putIfAbsent(animeId, () => []);

    if(!watchedEpisodeMap[animeId].contains(episodeId)) {
      watchedEpisodeMap[animeId].add(episodeId);
      databaseProvider.insertWatchedEpisode(animeId, episodeId);
    }
  }

  bool _isInMyList(String animeId) => myAnimeMap.containsKey(animeId);

  @action
  removeWatchedEpisode(String animeId, String episodeId) {
    if (!_isInMyList(animeId))
      return;

    if (watchedEpisodeMap[animeId] != null){
      watchedEpisodeMap[animeId].remove(episodeId);
      databaseProvider.removeWatchedEpisode(animeId, episodeId);
    }
  }

  @action
  clearAnimeWatchedEpisodes(String animeId) {
    watchedEpisodeMap.remove(animeId);
    databaseProvider.removeAllWatchedEpisodes(animeId);
  }

  @action
  clearWatchedEpisodeMap() {
    watchedEpisodeMap.clear();
    databaseProvider.clearWatchedEpisodes();
  }

  @action
  setLatestEpisodes(List<EpisodeItem> data) => latestEpisodes = ObservableList.of(data);

  @action
  setAnimeListLoadingStatus(LoadingStatus status) => animeListLoadingStatus = status;

  @action
  addAnimeItem(List<AnimeItem> data) => mainAnimeList.addAll( data );

  @action
  setAppInitialization(AppInitStatus status) => appInitStatus = status;

  @action
  setMostRecentAnimeList(List<AnimeItem> data) => mostRecentAnimeList = ObservableList.of(data);
  
  @action
  setDailyReleases( List<AnimeItem> data ) => dayReleaseList = ObservableList.of(data);

  @action
  setTopAnimeList ( List<AnimeItem> data) => topAnimeList = ObservableList.of(data);

  @action
  setGenreList( List<String>  data) => genreList = ObservableList.of(data);

  @action
  setMyAnimeMap( Map<String,AnimeItem> data) => myAnimeMap = ObservableMap.of(data);

  @action
  addToAnimeMap(String key, AnimeItem data) => myAnimeMap.putIfAbsent(
      key,
          () {
            databaseProvider.insertAnimeToList(key, data);
            return data;
          });

  @action
  removeFromAnimeMap(String id) {

    myAnimeMap.remove(id);
    databaseProvider.removeAnimeFromList(id);

    if (watchedEpisodeMap.containsKey(id)){
      watchedEpisodeMap.remove(id);
      databaseProvider.removeAllWatchedEpisodes(id);
    }
  }

  bool isEpisodeWatched(String animeId, String episodeId)
    => watchedEpisodeMap[animeId]?.contains(episodeId) ?? false;

  void initApp() async {
    if (appInitStatus == AppInitStatus.INITIALIZED)
      return;

      try {
        await databaseProvider.init();

        await loadMyAnimeMap();
        await loadWatchedEpisodes();
        await getHomePageInfo();
        await loadAnimeList();
        await getGenresAvailable();
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
    setMostRecentAnimeList( homePageData.mostRecentAnimes );
    setTopAnimeList( homePageData.mostShowedAnimes);
    setLatestEpisodes(  homePageData.latestEpisodes
      ..removeWhere( (item) => item.title.contains('anúncios')) );
    setDailyReleases( homePageData.dayReleases);

  }

  Future<void> getGenresAvailable() async {
    List<String> data = await api.getGenresAvailable(timeout: TIMEOUT);
    setGenreList(data );
  }

  Future<void> loadMyAnimeMap() async {
    Map<String,AnimeItem> data = await databaseProvider.loadMyAnimeList();
    //print('Loaded from LOCAL $data');
    setMyAnimeMap(data);
  }

  Future<void> loadWatchedEpisodes() async {
    Map<String, List<String>> data =
        await databaseProvider.loadWatchedEpisodes();

    setWatchedEpisodeMap(data);
  }
}