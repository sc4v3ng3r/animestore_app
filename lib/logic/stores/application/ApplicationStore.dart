import 'package:anime_app/database/DatabaseProvider.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/model/AppInfo.dart';
import 'package:anime_app/src/features/animestore_settings/domain/model/animestore_feature_settings.model.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:anime_app/model/EpisodeWatched.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../src/core/domain/models/content/animestore_content_settings.model.dart';
import '../../../src/core/domain/models/animestore_content_item.model.dart';
import '../../../src/core/domain/models/features/animestore_features.dart';
import '../../../src/core/external/global_declarations.dart';
import '../../../src/core/domain/models/http/animestore_http_request.model.dart';
import '../../../src/features/animestore_settings/domain/model/animestore_app_settings.model.dart';
import '../../../src/features/animestore_settings/infrastructure/repository/animestore_remote_app_settings.repo.impl.dart';
import '../../../src/features/anitube/external/datasource/anitube_home_datasource.impl.dart';

part 'ApplicationStore.g.dart';

class ApplicationStore = _ApplicationStore with _$ApplicationStore;

abstract class _ApplicationStore with Store {
  final AniTubeApi api = AniTubeApi(Dio());
  final DatabaseProvider databaseProvider = DatabaseProvider();

  late AppInfo _appInfo;
  late AnimestoreAppSettings _appSettings;
  AnimestoreAppSettings get appSettings => _appSettings;

  AnimestoreFeatureSettings getFeatureSettings(AnimestoreFeature feature) =>
      appSettings.features[feature.featureName]!;

  double topAnimeOffset = 0,
      myListOffset = 0,
      mostRecentOffset = 0,
      genreListOffset = .0;

  bool isFirstHomePageView = true;

  // This list holds the anime feed list.
  @observable
  ObservableList<AnimestoreContentItem> feedAnimeList = ObservableList();

  @observable
  ObservableList<AnimestoreContentItem> mostRecentAnimeList = ObservableList();

  @observable
  ObservableList<AnimestoreContentItem> topAnimeList = ObservableList();

  @observable
  ObservableList<AnimestoreContentItem> dayReleaseList = ObservableList();

  @observable
  ObservableList<String> genreList = ObservableList();

  /// Animes which the user has added to list. The map holds <animeId, AnimeItem>.
  @observable
  ObservableMap<String, AnimestoreContentItem> myAnimeMap = ObservableMap();

  @observable
  ObservableMap<String, EpisodeWatched> watchedEpisodeMap = ObservableMap();

  @observable
  ObservableList<AnimestoreContentItem> latestEpisodes = ObservableList();

  /// counter of main animes list pages.
  int mainAnimesPageCounter = 1;
  int maxMainAnimesPageNumber = 1;
  int mainCarouselCurrentPosition = 1;

  @observable
  AppInitStatus appInitStatus = AppInitStatus.INITIALIZING;

  @action
  setWatchedEpisodeMap(Map<String, EpisodeWatched> data) =>
      watchedEpisodeMap = ObservableMap.of(data);

  @action
  addWatchedEpisode(
    String episodeId, {
    String? episodeTitle,
    int? viewedAt,
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
  setLatestEpisodes(List<AnimestoreContentItem> data) =>
      latestEpisodes = ObservableList.of(data);

  @action
  addAnimeItem(List<AnimestoreContentItem> data) => feedAnimeList.addAll(data);

  @action
  setAppInitialization(AppInitStatus status) => appInitStatus = status;

  @action
  setMostRecentAnimeList(List<AnimestoreContentItem> data) =>
      mostRecentAnimeList = ObservableList.of(data);

  @action
  setDailyReleases(List<AnimestoreContentItem> data) =>
      dayReleaseList = ObservableList.of(data);

  @action
  setTopAnimeList(List<AnimestoreContentItem> data) =>
      topAnimeList = ObservableList.of(data);

  @action
  setGenreList(List<String> data) => genreList = ObservableList.of(data);

  @action
  setMyAnimeMap(Map<String, AnimestoreContentItem> data) =>
      myAnimeMap = ObservableMap.of(data);

  @action
  addToAnimeMap(String key, AnimestoreContentItem data) =>
      myAnimeMap.putIfAbsent(key, () {
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
      watchedEpisodeMap.containsKey(episodeId);

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
    // await loadMyAnimeMap();
    await loadWatchedEpisodes();
    await getHomePageInfo();
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

  Future<void> refreshHome() async {
    await getHomePageInfo();
    await getGenresAvailable();
  }

  Future<void> getHomePageInfo() async {
    _appSettings = await getIt<AnimestoreRemoteAppSettingsRepositoryImpl>()
        .getAppSettings();

    final dataSource = getIt<AnitubeHomeDatasourceImpl>();

    final homeFeatureSettings = _appSettings.features['home'];
    // loading home data
    final basicHomeContent =
        await dataSource.exec(AnimeStoreContentSettingsImpl(
      declaration: homeFeatureSettings!.parserDeclaration,
      request: AnimeStoreHttpRequestImpl(
          baseUrl: homeFeatureSettings.apiSettings.baseUrl,
          method: homeFeatureSettings.apiSettings.method),
    ));

    setMostRecentAnimeList(basicHomeContent.mostViewedAnimes);
    setTopAnimeList(basicHomeContent.topAnimes);
    setDailyReleases(basicHomeContent.dailyAnimeReleases);

    setLatestEpisodes(basicHomeContent.recentEpisodes
      ..removeWhere((item) => item.title.contains('anúncios')));
  }

  Future<void> getGenresAvailable() async {
    List<Genre> data = await api.getGenresAvailable();
    setGenreList(data.map((e) => e.title).toList());
  }

  // Future<void> loadMyAnimeMap() async {
  //   Map<String, AnimeItem> data = await databaseProvider.loadMyAnimeList();
  //   setMyAnimeMap(data);
  // }

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
