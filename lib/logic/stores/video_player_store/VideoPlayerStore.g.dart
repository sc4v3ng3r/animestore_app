// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoPlayerStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VideoPlayerStore on _VideoPlayerStore, Store {
  final _$episodeLoadingStatusAtom =
      Atom(name: '_VideoPlayerStore.episodeLoadingStatus');

  @override
  EpisodeStatus get episodeLoadingStatus {
    _$episodeLoadingStatusAtom.reportRead();
    return super.episodeLoadingStatus;
  }

  @override
  set episodeLoadingStatus(EpisodeStatus value) {
    _$episodeLoadingStatusAtom.reportWrite(value, super.episodeLoadingStatus,
        () {
      super.episodeLoadingStatus = value;
    });
  }

  final _$isPlayingAtom = Atom(name: '_VideoPlayerStore.isPlaying');

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  final _$currentPositionAtom = Atom(name: '_VideoPlayerStore.currentPosition');

  @override
  Duration get currentPosition {
    _$currentPositionAtom.reportRead();
    return super.currentPosition;
  }

  @override
  set currentPosition(Duration value) {
    _$currentPositionAtom.reportWrite(value, super.currentPosition, () {
      super.currentPosition = value;
    });
  }

  final _$_VideoPlayerStoreActionController =
      ActionController(name: '_VideoPlayerStore');

  @override
  dynamic setEpisodeLoadingStatus(EpisodeStatus status) {
    final _$actionInfo = _$_VideoPlayerStoreActionController.startAction(
        name: '_VideoPlayerStore.setEpisodeLoadingStatus');
    try {
      return super.setEpisodeLoadingStatus(status);
    } finally {
      _$_VideoPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setPlayingStatus(bool status) {
    final _$actionInfo = _$_VideoPlayerStoreActionController.startAction(
        name: '_VideoPlayerStore._setPlayingStatus');
    try {
      return super._setPlayingStatus(status);
    } finally {
      _$_VideoPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setCurrentPosition(Duration duration) {
    final _$actionInfo = _$_VideoPlayerStoreActionController.startAction(
        name: '_VideoPlayerStore._setCurrentPosition');
    try {
      return super._setCurrentPosition(duration);
    } finally {
      _$_VideoPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
episodeLoadingStatus: ${episodeLoadingStatus},
isPlaying: ${isPlaying},
currentPosition: ${currentPosition}
    ''';
  }
}
