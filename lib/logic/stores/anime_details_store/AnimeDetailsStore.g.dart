// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnimeDetailsStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AnimeDetailsStore on _AnimeDetailsStore, Store {
  final _$backgroundColorAtom =
      Atom(name: '_AnimeDetailsStore.backgroundColor');

  @override
  Color get backgroundColor {
    _$backgroundColorAtom.context.enforceReadPolicy(_$backgroundColorAtom);
    _$backgroundColorAtom.reportObserved();
    return super.backgroundColor;
  }

  @override
  set backgroundColor(Color value) {
    _$backgroundColorAtom.context.conditionallyRunInAction(() {
      super.backgroundColor = value;
      _$backgroundColorAtom.reportChanged();
    }, _$backgroundColorAtom, name: '${_$backgroundColorAtom.name}_set');
  }

  final _$loadingStatusAtom = Atom(name: '_AnimeDetailsStore.loadingStatus');

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

  final _$visualizedEpsAtom = Atom(name: '_AnimeDetailsStore.visualizedEps');

  @override
  ObservableList<String> get visualizedEps {
    _$visualizedEpsAtom.context.enforceReadPolicy(_$visualizedEpsAtom);
    _$visualizedEpsAtom.reportObserved();
    return super.visualizedEps;
  }

  @override
  set visualizedEps(ObservableList<String> value) {
    _$visualizedEpsAtom.context.conditionallyRunInAction(() {
      super.visualizedEps = value;
      _$visualizedEpsAtom.reportChanged();
    }, _$visualizedEpsAtom, name: '${_$visualizedEpsAtom.name}_set');
  }

  final _$tabChoiceAtom = Atom(name: '_AnimeDetailsStore.tabChoice');

  @override
  TabChoice get tabChoice {
    _$tabChoiceAtom.context.enforceReadPolicy(_$tabChoiceAtom);
    _$tabChoiceAtom.reportObserved();
    return super.tabChoice;
  }

  @override
  set tabChoice(TabChoice value) {
    _$tabChoiceAtom.context.conditionallyRunInAction(() {
      super.tabChoice = value;
      _$tabChoiceAtom.reportChanged();
    }, _$tabChoiceAtom, name: '${_$tabChoiceAtom.name}_set');
  }

  final _$relatedAnimesAtom = Atom(name: '_AnimeDetailsStore.relatedAnimes');

  @override
  ObservableList<AnimeItem> get relatedAnimes {
    _$relatedAnimesAtom.context.enforceReadPolicy(_$relatedAnimesAtom);
    _$relatedAnimesAtom.reportObserved();
    return super.relatedAnimes;
  }

  @override
  set relatedAnimes(ObservableList<AnimeItem> value) {
    _$relatedAnimesAtom.context.conditionallyRunInAction(() {
      super.relatedAnimes = value;
      _$relatedAnimesAtom.reportChanged();
    }, _$relatedAnimesAtom, name: '${_$relatedAnimesAtom.name}_set');
  }

  final _$_AnimeDetailsStoreActionController =
      ActionController(name: '_AnimeDetailsStore');

  @override
  dynamic setLoadingStatus(LoadingStatus data) {
    final _$actionInfo = _$_AnimeDetailsStoreActionController.startAction();
    try {
      return super.setLoadingStatus(data);
    } finally {
      _$_AnimeDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addVisualizedEp(String episodeId) {
    final _$actionInfo = _$_AnimeDetailsStoreActionController.startAction();
    try {
      return super.addVisualizedEp(episodeId);
    } finally {
      _$_AnimeDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBackgroundColor(Color color) {
    final _$actionInfo = _$_AnimeDetailsStoreActionController.startAction();
    try {
      return super.setBackgroundColor(color);
    } finally {
      _$_AnimeDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTabChoice(TabChoice choice) {
    final _$actionInfo = _$_AnimeDetailsStoreActionController.startAction();
    try {
      return super.setTabChoice(choice);
    } finally {
      _$_AnimeDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setRelatedAnimes(List<AnimeItem> data) {
    final _$actionInfo = _$_AnimeDetailsStoreActionController.startAction();
    try {
      return super.setRelatedAnimes(data);
    } finally {
      _$_AnimeDetailsStoreActionController.endAction(_$actionInfo);
    }
  }
}
