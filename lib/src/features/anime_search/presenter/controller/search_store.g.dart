// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchStore on _SearchStore, Store {
  late final _$isLoadingMoreAtom =
      Atom(name: '_SearchStore.isLoadingMore', context: context);

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

  late final _$searchItemListAtom =
      Atom(name: '_SearchStore.searchItemList', context: context);

  @override
  ObservableList<AnimestoreContentItem> get searchItemList {
    _$searchItemListAtom.reportRead();
    return super.searchItemList;
  }

  @override
  set searchItemList(ObservableList<AnimestoreContentItem> value) {
    _$searchItemListAtom.reportWrite(value, super.searchItemList, () {
      super.searchItemList = value;
    });
  }

  late final _$searchStateAtom =
      Atom(name: '_SearchStore.searchState', context: context);

  @override
  SearchState get searchState {
    _$searchStateAtom.reportRead();
    return super.searchState;
  }

  @override
  set searchState(SearchState value) {
    _$searchStateAtom.reportWrite(value, super.searchState, () {
      super.searchState = value;
    });
  }

  late final _$_SearchStoreActionController =
      ActionController(name: '_SearchStore', context: context);

  @override
  dynamic setLoadingMore(bool flag) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.setLoadingMore');
    try {
      return super.setLoadingMore(flag);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addSearchItemList(List<AnimestoreContentItem> data) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.addSearchItemList');
    try {
      return super.addSearchItemList(data);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchItems(List<AnimestoreContentItem> data) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.setSearchItems');
    try {
      return super.setSearchItems(data);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchStatus(SearchState state) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.setSearchStatus');
    try {
      return super.setSearchStatus(state);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearSearchItems() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.clearSearchItems');
    try {
      return super.clearSearchItems();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearSearch() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.clearSearch');
    try {
      return super.clearSearch();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoadingMore: ${isLoadingMore},
searchItemList: ${searchItemList},
searchState: ${searchState}
    ''';
  }
}
