// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnimeDetailsStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnimeDetailsStore on _AnimeDetailsStore, Store {
  late final _$backgroundColorAtom =
      Atom(name: '_AnimeDetailsStore.backgroundColor', context: context);

  @override
  Color get backgroundColor {
    _$backgroundColorAtom.reportRead();
    return super.backgroundColor;
  }

  @override
  set backgroundColor(Color value) {
    _$backgroundColorAtom.reportWrite(value, super.backgroundColor, () {
      super.backgroundColor = value;
    });
  }

  late final _$loadingStatusAtom =
      Atom(name: '_AnimeDetailsStore.loadingStatus', context: context);

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

  late final _$visualizedEpsAtom =
      Atom(name: '_AnimeDetailsStore.visualizedEps', context: context);

  @override
  ObservableList<String> get visualizedEps {
    _$visualizedEpsAtom.reportRead();
    return super.visualizedEps;
  }

  @override
  set visualizedEps(ObservableList<String> value) {
    _$visualizedEpsAtom.reportWrite(value, super.visualizedEps, () {
      super.visualizedEps = value;
    });
  }

  late final _$tabChoiceAtom =
      Atom(name: '_AnimeDetailsStore.tabChoice', context: context);

  @override
  TabChoice get tabChoice {
    _$tabChoiceAtom.reportRead();
    return super.tabChoice;
  }

  @override
  set tabChoice(TabChoice value) {
    _$tabChoiceAtom.reportWrite(value, super.tabChoice, () {
      super.tabChoice = value;
    });
  }

  late final _$relatedAnimesAtom =
      Atom(name: '_AnimeDetailsStore.relatedAnimes', context: context);

  @override
  ObservableList<AnimeItem>? get relatedAnimes {
    _$relatedAnimesAtom.reportRead();
    return super.relatedAnimes;
  }

  @override
  set relatedAnimes(ObservableList<AnimeItem>? value) {
    _$relatedAnimesAtom.reportWrite(value, super.relatedAnimes, () {
      super.relatedAnimes = value;
    });
  }

  late final _$_AnimeDetailsStoreActionController =
      ActionController(name: '_AnimeDetailsStore', context: context);

  @override
  dynamic setLoadingStatus(LoadingStatus data) {
    final _$actionInfo = _$_AnimeDetailsStoreActionController.startAction(
        name: '_AnimeDetailsStore.setLoadingStatus');
    try {
      return super.setLoadingStatus(data);
    } finally {
      _$_AnimeDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addVisualizedEp(String episodeId) {
    final _$actionInfo = _$_AnimeDetailsStoreActionController.startAction(
        name: '_AnimeDetailsStore.addVisualizedEp');
    try {
      return super.addVisualizedEp(episodeId);
    } finally {
      _$_AnimeDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBackgroundColor(Color color) {
    final _$actionInfo = _$_AnimeDetailsStoreActionController.startAction(
        name: '_AnimeDetailsStore.setBackgroundColor');
    try {
      return super.setBackgroundColor(color);
    } finally {
      _$_AnimeDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTabChoice(TabChoice choice) {
    final _$actionInfo = _$_AnimeDetailsStoreActionController.startAction(
        name: '_AnimeDetailsStore.setTabChoice');
    try {
      return super.setTabChoice(choice);
    } finally {
      _$_AnimeDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setRelatedAnimes(List<AnimeItem> data) {
    final _$actionInfo = _$_AnimeDetailsStoreActionController.startAction(
        name: '_AnimeDetailsStore.setRelatedAnimes');
    try {
      return super.setRelatedAnimes(data);
    } finally {
      _$_AnimeDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
backgroundColor: ${backgroundColor},
loadingStatus: ${loadingStatus},
visualizedEps: ${visualizedEps},
tabChoice: ${tabChoice},
relatedAnimes: ${relatedAnimes}
    ''';
  }
}
