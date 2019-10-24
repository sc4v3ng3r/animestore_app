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
}
