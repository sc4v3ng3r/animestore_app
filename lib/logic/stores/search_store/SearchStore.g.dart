// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStore, Store {
  final _$isLoadingMoreAtom = Atom(name: '_SearchStore.isLoadingMore');

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

  final _$searchItemListAtom = Atom(name: '_SearchStore.searchItemList');

  @override
  ObservableList<AnimeItem> get searchItemList {
    _$searchItemListAtom.context.enforceReadPolicy(_$searchItemListAtom);
    _$searchItemListAtom.reportObserved();
    return super.searchItemList;
  }

  @override
  set searchItemList(ObservableList<AnimeItem> value) {
    _$searchItemListAtom.context.conditionallyRunInAction(() {
      super.searchItemList = value;
      _$searchItemListAtom.reportChanged();
    }, _$searchItemListAtom, name: '${_$searchItemListAtom.name}_set');
  }

  final _$searchStateAtom = Atom(name: '_SearchStore.searchState');

  @override
  SearchState get searchState {
    _$searchStateAtom.context.enforceReadPolicy(_$searchStateAtom);
    _$searchStateAtom.reportObserved();
    return super.searchState;
  }

  @override
  set searchState(SearchState value) {
    _$searchStateAtom.context.conditionallyRunInAction(() {
      super.searchState = value;
      _$searchStateAtom.reportChanged();
    }, _$searchStateAtom, name: '${_$searchStateAtom.name}_set');
  }

  final _$_SearchStoreActionController = ActionController(name: '_SearchStore');

  @override
  dynamic setLoadingMore(bool flag) {
    final _$actionInfo = _$_SearchStoreActionController.startAction();
    try {
      return super.setLoadingMore(flag);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addSearchItemList(List<AnimeItem> data) {
    final _$actionInfo = _$_SearchStoreActionController.startAction();
    try {
      return super.addSearchItemList(data);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchItems(List<AnimeItem> data) {
    final _$actionInfo = _$_SearchStoreActionController.startAction();
    try {
      return super.setSearchItems(data);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchStatus(SearchState state) {
    final _$actionInfo = _$_SearchStoreActionController.startAction();
    try {
      return super.setSearchStatus(state);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearSearchItems() {
    final _$actionInfo = _$_SearchStoreActionController.startAction();
    try {
      return super.clearSearchItems();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearSearch() {
    final _$actionInfo = _$_SearchStoreActionController.startAction();
    try {
      return super.clearSearch();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }
}
