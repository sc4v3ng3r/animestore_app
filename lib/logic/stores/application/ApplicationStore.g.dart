// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApplicationStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ApplicationStore on _ApplicationStore, Store {
  late final _$feedAnimeListAtom =
      Atom(name: '_ApplicationStore.feedAnimeList', context: context);

  @override
  ObservableList<AnimestoreContentItem> get feedAnimeList {
    _$feedAnimeListAtom.reportRead();
    return super.feedAnimeList;
  }

  @override
  set feedAnimeList(ObservableList<AnimestoreContentItem> value) {
    _$feedAnimeListAtom.reportWrite(value, super.feedAnimeList, () {
      super.feedAnimeList = value;
    });
  }

  late final _$mostRecentAnimeListAtom =
      Atom(name: '_ApplicationStore.mostRecentAnimeList', context: context);

  @override
  ObservableList<AnimestoreContentItem> get mostRecentAnimeList {
    _$mostRecentAnimeListAtom.reportRead();
    return super.mostRecentAnimeList;
  }

  @override
  set mostRecentAnimeList(ObservableList<AnimestoreContentItem> value) {
    _$mostRecentAnimeListAtom.reportWrite(value, super.mostRecentAnimeList, () {
      super.mostRecentAnimeList = value;
    });
  }

  late final _$topAnimeListAtom =
      Atom(name: '_ApplicationStore.topAnimeList', context: context);

  @override
  ObservableList<AnimestoreContentItem> get topAnimeList {
    _$topAnimeListAtom.reportRead();
    return super.topAnimeList;
  }

  @override
  set topAnimeList(ObservableList<AnimestoreContentItem> value) {
    _$topAnimeListAtom.reportWrite(value, super.topAnimeList, () {
      super.topAnimeList = value;
    });
  }

  late final _$dayReleaseListAtom =
      Atom(name: '_ApplicationStore.dayReleaseList', context: context);

  @override
  ObservableList<AnimestoreContentItem> get dayReleaseList {
    _$dayReleaseListAtom.reportRead();
    return super.dayReleaseList;
  }

  @override
  set dayReleaseList(ObservableList<AnimestoreContentItem> value) {
    _$dayReleaseListAtom.reportWrite(value, super.dayReleaseList, () {
      super.dayReleaseList = value;
    });
  }

  late final _$genreListAtom =
      Atom(name: '_ApplicationStore.genreList', context: context);

  @override
  ObservableList<String> get genreList {
    _$genreListAtom.reportRead();
    return super.genreList;
  }

  @override
  set genreList(ObservableList<String> value) {
    _$genreListAtom.reportWrite(value, super.genreList, () {
      super.genreList = value;
    });
  }

  late final _$myAnimeMapAtom =
      Atom(name: '_ApplicationStore.myAnimeMap', context: context);

  @override
  ObservableMap<String, AnimeItem> get myAnimeMap {
    _$myAnimeMapAtom.reportRead();
    return super.myAnimeMap;
  }

  @override
  set myAnimeMap(ObservableMap<String, AnimeItem> value) {
    _$myAnimeMapAtom.reportWrite(value, super.myAnimeMap, () {
      super.myAnimeMap = value;
    });
  }

  late final _$watchedEpisodeMapAtom =
      Atom(name: '_ApplicationStore.watchedEpisodeMap', context: context);

  @override
  ObservableMap<String, EpisodeWatched> get watchedEpisodeMap {
    _$watchedEpisodeMapAtom.reportRead();
    return super.watchedEpisodeMap;
  }

  @override
  set watchedEpisodeMap(ObservableMap<String, EpisodeWatched> value) {
    _$watchedEpisodeMapAtom.reportWrite(value, super.watchedEpisodeMap, () {
      super.watchedEpisodeMap = value;
    });
  }

  late final _$latestEpisodesAtom =
      Atom(name: '_ApplicationStore.latestEpisodes', context: context);

  @override
  ObservableList<AnimestoreContentItem> get latestEpisodes {
    _$latestEpisodesAtom.reportRead();
    return super.latestEpisodes;
  }

  @override
  set latestEpisodes(ObservableList<AnimestoreContentItem> value) {
    _$latestEpisodesAtom.reportWrite(value, super.latestEpisodes, () {
      super.latestEpisodes = value;
    });
  }

  late final _$animeListLoadingStatusAtom =
      Atom(name: '_ApplicationStore.animeListLoadingStatus', context: context);

  @override
  LoadingStatus get animeListLoadingStatus {
    _$animeListLoadingStatusAtom.reportRead();
    return super.animeListLoadingStatus;
  }

  @override
  set animeListLoadingStatus(LoadingStatus value) {
    _$animeListLoadingStatusAtom
        .reportWrite(value, super.animeListLoadingStatus, () {
      super.animeListLoadingStatus = value;
    });
  }

  late final _$appInitStatusAtom =
      Atom(name: '_ApplicationStore.appInitStatus', context: context);

  @override
  AppInitStatus get appInitStatus {
    _$appInitStatusAtom.reportRead();
    return super.appInitStatus;
  }

  @override
  set appInitStatus(AppInitStatus value) {
    _$appInitStatusAtom.reportWrite(value, super.appInitStatus, () {
      super.appInitStatus = value;
    });
  }

  late final _$_ApplicationStoreActionController =
      ActionController(name: '_ApplicationStore', context: context);

  @override
  dynamic setWatchedEpisodeMap(Map<String, EpisodeWatched> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setWatchedEpisodeMap');
    try {
      return super.setWatchedEpisodeMap(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addWatchedEpisode(String episodeId,
      {String? episodeTitle, int? viewedAt}) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.addWatchedEpisode');
    try {
      return super.addWatchedEpisode(episodeId,
          episodeTitle: episodeTitle, viewedAt: viewedAt);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeWatchedEpisode(String episodeId) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.removeWatchedEpisode');
    try {
      return super.removeWatchedEpisode(episodeId);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearWatchedEpisodeMap() {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.clearWatchedEpisodeMap');
    try {
      return super.clearWatchedEpisodeMap();
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMyList() {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.clearMyList');
    try {
      return super.clearMyList();
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLatestEpisodes(List<AnimestoreContentItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setLatestEpisodes');
    try {
      return super.setLatestEpisodes(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAnimeListLoadingStatus(LoadingStatus status) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setAnimeListLoadingStatus');
    try {
      return super.setAnimeListLoadingStatus(status);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addAnimeItem(List<AnimestoreContentItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.addAnimeItem');
    try {
      return super.addAnimeItem(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAppInitialization(AppInitStatus status) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setAppInitialization');
    try {
      return super.setAppInitialization(status);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMostRecentAnimeList(List<AnimestoreContentItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setMostRecentAnimeList');
    try {
      return super.setMostRecentAnimeList(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDailyReleases(List<AnimestoreContentItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setDailyReleases');
    try {
      return super.setDailyReleases(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTopAnimeList(List<AnimestoreContentItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setTopAnimeList');
    try {
      return super.setTopAnimeList(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setGenreList(List<String> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setGenreList');
    try {
      return super.setGenreList(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMyAnimeMap(Map<String, AnimeItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.setMyAnimeMap');
    try {
      return super.setMyAnimeMap(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addToAnimeMap(String key, AnimeItem data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.addToAnimeMap');
    try {
      return super.addToAnimeMap(key, data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeFromAnimeMap(String id) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction(
        name: '_ApplicationStore.removeFromAnimeMap');
    try {
      return super.removeFromAnimeMap(id);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
feedAnimeList: ${feedAnimeList},
mostRecentAnimeList: ${mostRecentAnimeList},
topAnimeList: ${topAnimeList},
dayReleaseList: ${dayReleaseList},
genreList: ${genreList},
myAnimeMap: ${myAnimeMap},
watchedEpisodeMap: ${watchedEpisodeMap},
latestEpisodes: ${latestEpisodes},
animeListLoadingStatus: ${animeListLoadingStatus},
appInitStatus: ${appInitStatus}
    ''';
  }
}
