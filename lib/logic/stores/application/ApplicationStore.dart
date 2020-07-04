import 'package:anime_app/database/DatabaseProvider.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/model/AppInfo.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info/package_info.dart';

import 'package:anime_app/model/EpisodeWatched.dart';

part 'ApplicationStore.g.dart';

class ApplicationStore = _ApplicationStore with _$ApplicationStore;

abstract class _ApplicationStore with Store {
  final AniTubeApi api = AniTubeApi();
  final DatabaseProvider databaseProvider = DatabaseProvider();
  static const DEFAULT_PAGES_LOADING = 4;
  static const TIMEOUT = 10000;
  AppInfo _appInfo;

  double topAnimeOffset = 0,
      myListOffset = 0,
      mainAnimeListOffset = 0,
      mostRecentOffset = 0,
      genreListOffset = .0;

  bool isFirstHomePageView = true;

  // This list holds the anime feed list.
  @observable
  ObservableList<AnimeItem> feedAnimeList = ObservableList();

  @observable
  ObservableList<AnimeItem> mostRecentAnimeList = ObservableList();

  @observable
  ObservableList<AnimeItem> topAnimeList = ObservableList();

  @observable
  ObservableList<AnimeItem> dayReleaseList = ObservableList();

  @observable
  ObservableList<String> genreList = ObservableList();

  /// Animes which the user has added to list. The map holds <animeId, AnimeItem>.
  @observable
  ObservableMap<String, AnimeItem> myAnimeMap = ObservableMap();

  @observable
  ObservableMap<String, EpisodeWatched> watchedEpisodeMap = ObservableMap();

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
  setWatchedEpisodeMap(Map<String, EpisodeWatched> data) =>
      watchedEpisodeMap = ObservableMap.of(data);

  @action
  addWatchedEpisode(
    String episodeId, {
    String episodeTitle,
    int viewedAt,
  }) {
    if (!watchedEpisodeMap.containsKey(episodeId)) {
      var item = EpisodeWatched(
          viewedAt: viewedAt, id: episodeId, title: episodeTitle);
      watchedEpisodeMap.putIfAbsent(episodeId, () => item);
      databaseProvider.insertWatchedEpisode(item);
    }
  }

  @action
  removeWatchedEpisode(String episodeId) {
    if (watchedEpisodeMap.containsKey(episodeId)) {
      watchedEpisodeMap.remove(episodeId);
      databaseProvider.removeWatchedEpisode(episodeId);
    }
  }

  @action
  clearWatchedEpisodeMap() {
    watchedEpisodeMap.clear();
    databaseProvider.clearWatchedEpisodes();
  }

  @action
  void clearMyList() {
    myAnimeMap.clear();
    databaseProvider.clearAllMyList();
  }

  @action
  setLatestEpisodes(List<EpisodeItem> data) =>
      latestEpisodes = ObservableList.of(data);

  @action
  setAnimeListLoadingStatus(LoadingStatus status) =>
      animeListLoadingStatus = status;

  @action
  addAnimeItem(List<AnimeItem> data) => feedAnimeList.addAll(data);

  @action
  setAppInitialization(AppInitStatus status) => appInitStatus = status;

  @action
  setMostRecentAnimeList(List<AnimeItem> data) =>
      mostRecentAnimeList = ObservableList.of(data);

  @action
  setDailyReleases(List<AnimeItem> data) =>
      dayReleaseList = ObservableList.of(data);

  @action
  setTopAnimeList(List<AnimeItem> data) =>
      topAnimeList = ObservableList.of(data);

  @action
  setGenreList(List<String> data) => genreList = ObservableList.of(data);

  @action
  setMyAnimeMap(Map<String, AnimeItem> data) =>
      myAnimeMap = ObservableMap.of(data);

  @action
  addToAnimeMap(String key, AnimeItem data) => myAnimeMap.putIfAbsent(key, () {
        databaseProvider.insertAnimeToList(key, data);
        return data;
      });

  @action
  removeFromAnimeMap(String id) {
    myAnimeMap.remove(id);
    databaseProvider.removeAnimeFromList(id);

    if (watchedEpisodeMap.containsKey(id)) {
      watchedEpisodeMap.remove(id);
    }
  }

  
  bool isEpisodeWatched(String episodeId) =>
      watchedEpisodeMap.containsKey(episodeId) ?? false;

  void initApp() async {
    if (appInitStatus == AppInitStatus.INITIALIZED) return;

    try {
      await databaseProvider.init();
      _getAppInfo();
      await _initDataFromNetwork();
      setAppInitialization(AppInitStatus.INITIALIZED);
    } on CrawlerApiException catch (ex) {
      print(ex);
      setAppInitialization(AppInitStatus.INIT_ERROR);
    }
  }

  Future<void> _initDataFromNetwork() async {
    await loadMyAnimeMap();
    await loadWatchedEpisodes();
    await getHomePageInfo();
    await loadAnimeList();
    await getGenresAvailable();
  }

  void appRetry() async {
    if (appInitStatus != AppInitStatus.INIT_ERROR) return;

    try {
      setAppInitialization(AppInitStatus.INITIALIZING);
      await _initDataFromNetwork();
      setAppInitialization(AppInitStatus.INITIALIZED);
    } on CrawlerApiException catch (ex) {
      print(ex);
      setAppInitialization(AppInitStatus.INIT_ERROR);
    }
  }

  // This method load the main anime list and handles also the pagination.
  // We must always load main anime list data with this method.
  Future<void> loadAnimeList() async {
    if (animeListLoadingStatus == LoadingStatus.LOADING) return;

    var cacheList = <AnimeItem>[];

    if (mainAnimesPageCounter <= maxMainAnimesPageNumber) {
      setAnimeListLoadingStatus(LoadingStatus.LOADING);

      for (int i = 0; i < DEFAULT_PAGES_LOADING; i++) {
        try {
          var data =
              await api.getAnimeListPageData(pageNumber: mainAnimesPageCounter);

          cacheList.addAll(data.animes);

          maxMainAnimesPageNumber = int.parse(data.maxPageNumber);
          mainAnimesPageCounter++;
        } on CrawlerApiException catch (ex) {
          print('Fail loding page number $mainAnimesPageCounter $ex');
          mainAnimesPageCounter++;
        }
      }
    }

    addAnimeItem(cacheList);
    setAnimeListLoadingStatus(LoadingStatus.DONE);
  }

  Future<AnimeDetails> getAnimeDetails(String id,) =>
      api.getAnimeDetails(id, timeout: TIMEOUT);

  Future<void> refreshHome() async {
    await getHomePageInfo();
    //await loadAnimeList();
    await getGenresAvailable();
  }

  Future<void> getHomePageInfo() async {
    var homePageData = await api.getHomePageData();
    setMostRecentAnimeList(homePageData.mostRecentAnimes);
    setTopAnimeList(homePageData.mostShowedAnimes);
    setLatestEpisodes(homePageData.latestEpisodes
      ..removeWhere((item) => item.title.contains('anúncios')));
    setDailyReleases(homePageData.dayReleases);
  }

  Future<void> getGenresAvailable() async {
    List<String> data = await api.getGenresAvailable(timeout: TIMEOUT);
    setGenreList(data);
  }

  Future<void> loadMyAnimeMap() async {
    Map<String, AnimeItem> data = await databaseProvider.loadMyAnimeList();
    setMyAnimeMap(data);
  }

  Future<void> _getAppInfo() async {
    try {
      var info = await PackageInfo.fromPlatform();

      _appInfo = AppInfo(
          appName: info.appName,
          buildNumber: info.buildNumber,
          version: info.version);
    } catch (ex) {
      print('ApplicationStore::_getAppInfo $ex');
      print('Not able to fetch AppInfo data.');
    }
  }

  AppInfo get appInfo => _appInfo;

  Future<void> loadWatchedEpisodes() async {
    var data = await databaseProvider.loadWatchedEpisodes();
    var map = <String, EpisodeWatched>{};

    data.forEach((ep) => map.putIfAbsent(ep.id, () => ep));
    setWatchedEpisodeMap(map);
  }
}
