// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoPlayerStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VideoPlayerStore on _VideoPlayerStore, Store {
  final _$episodeLoadingStatusAtom =
      Atom(name: '_VideoPlayerStore.episodeLoadingStatus');

  @override
  EpisodeStatus get episodeLoadingStatus {
    _$episodeLoadingStatusAtom.context
        .enforceReadPolicy(_$episodeLoadingStatusAtom);
    _$episodeLoadingStatusAtom.reportObserved();
    return super.episodeLoadingStatus;
  }

  @override
  set episodeLoadingStatus(EpisodeStatus value) {
    _$episodeLoadingStatusAtom.context.conditionallyRunInAction(() {
      super.episodeLoadingStatus = value;
      _$episodeLoadingStatusAtom.reportChanged();
    }, _$episodeLoadingStatusAtom,
        name: '${_$episodeLoadingStatusAtom.name}_set');
  }

  final _$isPlayingAtom = Atom(name: '_VideoPlayerStore.isPlaying');

  @override
  bool get isPlaying {
    _$isPlayingAtom.context.enforceReadPolicy(_$isPlayingAtom);
    _$isPlayingAtom.reportObserved();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.context.conditionallyRunInAction(() {
      super.isPlaying = value;
      _$isPlayingAtom.reportChanged();
    }, _$isPlayingAtom, name: '${_$isPlayingAtom.name}_set');
  }

  final _$currentPositionAtom = Atom(name: '_VideoPlayerStore.currentPosition');

  @override
  Duration get currentPosition {
    _$currentPositionAtom.context.enforceReadPolicy(_$currentPositionAtom);
    _$currentPositionAtom.reportObserved();
    return super.currentPosition;
  }

  @override
  set currentPosition(Duration value) {
    _$currentPositionAtom.context.conditionallyRunInAction(() {
      super.currentPosition = value;
      _$currentPositionAtom.reportChanged();
    }, _$currentPositionAtom, name: '${_$currentPositionAtom.name}_set');
  }

  final _$_VideoPlayerStoreActionController =
      ActionController(name: '_VideoPlayerStore');

  @override
  dynamic setEpisodeLoadingStatus(EpisodeStatus status) {
    final _$actionInfo = _$_VideoPlayerStoreActionController.startAction();
    try {
      return super.setEpisodeLoadingStatus(status);
    } finally {
      _$_VideoPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setPlayingStatus(bool status) {
    final _$actionInfo = _$_VideoPlayerStoreActionController.startAction();
    try {
      return super._setPlayingStatus(status);
    } finally {
      _$_VideoPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setCurrentPosition(Duration duration) {
    final _$actionInfo = _$_VideoPlayerStoreActionController.startAction();
    try {
      return super._setCurrentPosition(duration);
    } finally {
      _$_VideoPlayerStoreActionController.endAction(_$actionInfo);
    }
  }
}
