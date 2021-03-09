// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenreAnimeStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GenreAnimeStore on _GenreAnimeStore, Store {
  final _$animeItemsAtom = Atom(name: '_GenreAnimeStore.animeItems');

  @override
  ObservableList<AnimeItem> get animeItems {
    _$animeItemsAtom.reportRead();
    return super.animeItems;
  }

  @override
  set animeItems(ObservableList<AnimeItem> value) {
    _$animeItemsAtom.reportWrite(value, super.animeItems, () {
      super.animeItems = value;
    });
  }

  final _$loadingStatusAtom = Atom(name: '_GenreAnimeStore.loadingStatus');

  @override
  LoadingStatus get loadingStatus {
    _$loadingStatusAtom.reportRead();
    return super.loadingStatus;
  }

  @override
  set loadingStatus(LoadingStatus value) {
    _$loadingStatusAtom.reportWrite(value, super.loadingStatus, () {
      super.loadingStatus = value;
    });
  }

  final _$isLoadingMoreAtom = Atom(name: '_GenreAnimeStore.isLoadingMore');

  @override
  bool get isLoadingMore {
    _$isLoadingMoreAtom.reportRead();
    return super.isLoadingMore;
  }

  @override
  set isLoadingMore(bool value) {
    _$isLoadingMoreAtom.reportWrite(value, super.isLoadingMore, () {
      super.isLoadingMore = value;
    });
  }

  final _$_GenreAnimeStoreActionController =
      ActionController(name: '_GenreAnimeStore');

  @override
  dynamic setIsLoadingMore(bool flag) {
    final _$actionInfo = _$_GenreAnimeStoreActionController.startAction(
        name: '_GenreAnimeStore.setIsLoadingMore');
    try {
      return super.setIsLoadingMore(flag);
    } finally {
      _$_GenreAnimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoadingStatus(LoadingStatus data) {
    final _$actionInfo = _$_GenreAnimeStoreActionController.startAction(
        name: '_GenreAnimeStore.setLoadingStatus');
    try {
      return super.setLoadingStatus(data);
    } finally {
      _$_GenreAnimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAnimesItem(List<AnimeItem> data) {
    final _$actionInfo = _$_GenreAnimeStoreActionController.startAction(
        name: '_GenreAnimeStore.setAnimesItem');
    try {
      return super.setAnimesItem(data);
    } finally {
      _$_GenreAnimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addAnimeItems(List<AnimeItem> data) {
    final _$actionInfo = _$_GenreAnimeStoreActionController.startAction(
        name: '_GenreAnimeStore.addAnimeItems');
    try {
      return super.addAnimeItems(data);
    } finally {
      _$_GenreAnimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
animeItems: ${animeItems},
loadingStatus: ${loadingStatus},
isLoadingMore: ${isLoadingMore}
    ''';
  }
}
