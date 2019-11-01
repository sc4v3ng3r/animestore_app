// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenreAnimeStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GenreAnimeStore on _GenreAnimeStore, Store {
  final _$animeItemsAtom = Atom(name: '_GenreAnimeStore.animeItems');

  @override
  ObservableList<AnimeItem> get animeItems {
    _$animeItemsAtom.context.enforceReadPolicy(_$animeItemsAtom);
    _$animeItemsAtom.reportObserved();
    return super.animeItems;
  }

  @override
  set animeItems(ObservableList<AnimeItem> value) {
    _$animeItemsAtom.context.conditionallyRunInAction(() {
      super.animeItems = value;
      _$animeItemsAtom.reportChanged();
    }, _$animeItemsAtom, name: '${_$animeItemsAtom.name}_set');
  }

  final _$loadingStatusAtom = Atom(name: '_GenreAnimeStore.loadingStatus');

  @override
  LoadingStatus get loadingStatus {
    _$loadingStatusAtom.context.enforceReadPolicy(_$loadingStatusAtom);
    _$loadingStatusAtom.reportObserved();
    return super.loadingStatus;
  }

  @override
  set loadingStatus(LoadingStatus value) {
    _$loadingStatusAtom.context.conditionallyRunInAction(() {
      super.loadingStatus = value;
      _$loadingStatusAtom.reportChanged();
    }, _$loadingStatusAtom, name: '${_$loadingStatusAtom.name}_set');
  }

  final _$isLoadingMoreAtom = Atom(name: '_GenreAnimeStore.isLoadingMore');

  @override
  bool get isLoadingMore {
    _$isLoadingMoreAtom.context.enforceReadPolicy(_$isLoadingMoreAtom);
    _$isLoadingMoreAtom.reportObserved();
    return super.isLoadingMore;
  }

  @override
  set isLoadingMore(bool value) {
    _$isLoadingMoreAtom.context.conditionallyRunInAction(() {
      super.isLoadingMore = value;
      _$isLoadingMoreAtom.reportChanged();
    }, _$isLoadingMoreAtom, name: '${_$isLoadingMoreAtom.name}_set');
  }

  final _$_GenreAnimeStoreActionController =
      ActionController(name: '_GenreAnimeStore');

  @override
  dynamic setIsLoadingMore(bool flag) {
    final _$actionInfo = _$_GenreAnimeStoreActionController.startAction();
    try {
      return super.setIsLoadingMore(flag);
    } finally {
      _$_GenreAnimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoadingStatus(LoadingStatus data) {
    final _$actionInfo = _$_GenreAnimeStoreActionController.startAction();
    try {
      return super.setLoadingStatus(data);
    } finally {
      _$_GenreAnimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAnimesItem(List<AnimeItem> data) {
    final _$actionInfo = _$_GenreAnimeStoreActionController.startAction();
    try {
      return super.setAnimesItem(data);
    } finally {
      _$_GenreAnimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addAnimeItems(List<AnimeItem> data) {
    final _$actionInfo = _$_GenreAnimeStoreActionController.startAction();
    try {
      return super.addAnimeItems(data);
    } finally {
      _$_GenreAnimeStoreActionController.endAction(_$actionInfo);
    }
  }
}
