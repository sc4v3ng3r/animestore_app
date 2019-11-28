// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApplicationStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ApplicationStore on _ApplicationStore, Store {
  final _$mainAnimeListAtom = Atom(name: '_ApplicationStore.mainAnimeList');

  @override
  ObservableList<AnimeItem> get mainAnimeList {
    _$mainAnimeListAtom.context.enforceReadPolicy(_$mainAnimeListAtom);
    _$mainAnimeListAtom.reportObserved();
    return super.mainAnimeList;
  }

  @override
  set mainAnimeList(ObservableList<AnimeItem> value) {
    _$mainAnimeListAtom.context.conditionallyRunInAction(() {
      super.mainAnimeList = value;
      _$mainAnimeListAtom.reportChanged();
    }, _$mainAnimeListAtom, name: '${_$mainAnimeListAtom.name}_set');
  }

  final _$mostRecentAnimeListAtom =
      Atom(name: '_ApplicationStore.mostRecentAnimeList');

  @override
  ObservableList<AnimeItem> get mostRecentAnimeList {
    _$mostRecentAnimeListAtom.context
        .enforceReadPolicy(_$mostRecentAnimeListAtom);
    _$mostRecentAnimeListAtom.reportObserved();
    return super.mostRecentAnimeList;
  }

  @override
  set mostRecentAnimeList(ObservableList<AnimeItem> value) {
    _$mostRecentAnimeListAtom.context.conditionallyRunInAction(() {
      super.mostRecentAnimeList = value;
      _$mostRecentAnimeListAtom.reportChanged();
    }, _$mostRecentAnimeListAtom,
        name: '${_$mostRecentAnimeListAtom.name}_set');
  }

  final _$topAnimeListAtom = Atom(name: '_ApplicationStore.topAnimeList');

  @override
  ObservableList<AnimeItem> get topAnimeList {
    _$topAnimeListAtom.context.enforceReadPolicy(_$topAnimeListAtom);
    _$topAnimeListAtom.reportObserved();
    return super.topAnimeList;
  }

  @override
  set topAnimeList(ObservableList<AnimeItem> value) {
    _$topAnimeListAtom.context.conditionallyRunInAction(() {
      super.topAnimeList = value;
      _$topAnimeListAtom.reportChanged();
    }, _$topAnimeListAtom, name: '${_$topAnimeListAtom.name}_set');
  }

  final _$dayReleaseListAtom = Atom(name: '_ApplicationStore.dayReleaseList');

  @override
  ObservableList<AnimeItem> get dayReleaseList {
    _$dayReleaseListAtom.context.enforceReadPolicy(_$dayReleaseListAtom);
    _$dayReleaseListAtom.reportObserved();
    return super.dayReleaseList;
  }

  @override
  set dayReleaseList(ObservableList<AnimeItem> value) {
    _$dayReleaseListAtom.context.conditionallyRunInAction(() {
      super.dayReleaseList = value;
      _$dayReleaseListAtom.reportChanged();
    }, _$dayReleaseListAtom, name: '${_$dayReleaseListAtom.name}_set');
  }

  final _$genreListAtom = Atom(name: '_ApplicationStore.genreList');

  @override
  ObservableList<String> get genreList {
    _$genreListAtom.context.enforceReadPolicy(_$genreListAtom);
    _$genreListAtom.reportObserved();
    return super.genreList;
  }

  @override
  set genreList(ObservableList<String> value) {
    _$genreListAtom.context.conditionallyRunInAction(() {
      super.genreList = value;
      _$genreListAtom.reportChanged();
    }, _$genreListAtom, name: '${_$genreListAtom.name}_set');
  }

  final _$myAnimeMapAtom = Atom(name: '_ApplicationStore.myAnimeMap');

  @override
  ObservableMap<String, AnimeItem> get myAnimeMap {
    _$myAnimeMapAtom.context.enforceReadPolicy(_$myAnimeMapAtom);
    _$myAnimeMapAtom.reportObserved();
    return super.myAnimeMap;
  }

  @override
  set myAnimeMap(ObservableMap<String, AnimeItem> value) {
    _$myAnimeMapAtom.context.conditionallyRunInAction(() {
      super.myAnimeMap = value;
      _$myAnimeMapAtom.reportChanged();
    }, _$myAnimeMapAtom, name: '${_$myAnimeMapAtom.name}_set');
  }

  final _$watchedEpisodeMapAtom =
      Atom(name: '_ApplicationStore.watchedEpisodeMap');

  @override
  ObservableMap<String, List<String>> get watchedEpisodeMap {
    _$watchedEpisodeMapAtom.context.enforceReadPolicy(_$watchedEpisodeMapAtom);
    _$watchedEpisodeMapAtom.reportObserved();
    return super.watchedEpisodeMap;
  }

  @override
  set watchedEpisodeMap(ObservableMap<String, List<String>> value) {
    _$watchedEpisodeMapAtom.context.conditionallyRunInAction(() {
      super.watchedEpisodeMap = value;
      _$watchedEpisodeMapAtom.reportChanged();
    }, _$watchedEpisodeMapAtom, name: '${_$watchedEpisodeMapAtom.name}_set');
  }

  final _$latestEpisodesAtom = Atom(name: '_ApplicationStore.latestEpisodes');

  @override
  ObservableList<EpisodeItem> get latestEpisodes {
    _$latestEpisodesAtom.context.enforceReadPolicy(_$latestEpisodesAtom);
    _$latestEpisodesAtom.reportObserved();
    return super.latestEpisodes;
  }

  @override
  set latestEpisodes(ObservableList<EpisodeItem> value) {
    _$latestEpisodesAtom.context.conditionallyRunInAction(() {
      super.latestEpisodes = value;
      _$latestEpisodesAtom.reportChanged();
    }, _$latestEpisodesAtom, name: '${_$latestEpisodesAtom.name}_set');
  }

  final _$animeListLoadingStatusAtom =
      Atom(name: '_ApplicationStore.animeListLoadingStatus');

  @override
  LoadingStatus get animeListLoadingStatus {
    _$animeListLoadingStatusAtom.context
        .enforceReadPolicy(_$animeListLoadingStatusAtom);
    _$animeListLoadingStatusAtom.reportObserved();
    return super.animeListLoadingStatus;
  }

  @override
  set animeListLoadingStatus(LoadingStatus value) {
    _$animeListLoadingStatusAtom.context.conditionallyRunInAction(() {
      super.animeListLoadingStatus = value;
      _$animeListLoadingStatusAtom.reportChanged();
    }, _$animeListLoadingStatusAtom,
        name: '${_$animeListLoadingStatusAtom.name}_set');
  }

  final _$appInitStatusAtom = Atom(name: '_ApplicationStore.appInitStatus');

  @override
  AppInitStatus get appInitStatus {
    _$appInitStatusAtom.context.enforceReadPolicy(_$appInitStatusAtom);
    _$appInitStatusAtom.reportObserved();
    return super.appInitStatus;
  }

  @override
  set appInitStatus(AppInitStatus value) {
    _$appInitStatusAtom.context.conditionallyRunInAction(() {
      super.appInitStatus = value;
      _$appInitStatusAtom.reportChanged();
    }, _$appInitStatusAtom, name: '${_$appInitStatusAtom.name}_set');
  }

  final _$_ApplicationStoreActionController =
      ActionController(name: '_ApplicationStore');

  @override
  dynamic setWatchedEpisodeMap(Map<String, List<String>> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.setWatchedEpisodeMap(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addWatchedEpisode(String animeId, String episodeId) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.addWatchedEpisode(animeId, episodeId);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeWatchedEpisode(String animeId, String episodeId) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.removeWatchedEpisode(animeId, episodeId);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearAnimeWatchedEpisodes(String animeId) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.clearAnimeWatchedEpisodes(animeId);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearWatchedEpisodeMap() {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.clearWatchedEpisodeMap();
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLatestEpisodes(List<EpisodeItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.setLatestEpisodes(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAnimeListLoadingStatus(LoadingStatus status) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.setAnimeListLoadingStatus(status);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addAnimeItem(List<AnimeItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.addAnimeItem(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAppInitialization(AppInitStatus status) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.setAppInitialization(status);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMostRecentAnimeList(List<AnimeItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.setMostRecentAnimeList(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDailyReleases(List<AnimeItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.setDailyReleases(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTopAnimeList(List<AnimeItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.setTopAnimeList(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setGenreList(List<String> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.setGenreList(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMyAnimeMap(Map<String, AnimeItem> data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.setMyAnimeMap(data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addToAnimeMap(String key, AnimeItem data) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.addToAnimeMap(key, data);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeFromAnimeMap(String id) {
    final _$actionInfo = _$_ApplicationStoreActionController.startAction();
    try {
      return super.removeFromAnimeMap(id);
    } finally {
      _$_ApplicationStoreActionController.endAction(_$actionInfo);
    }
  }
}
