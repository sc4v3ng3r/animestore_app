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
  EpisodeLoading get episodeLoadingStatus {
    _$episodeLoadingStatusAtom.context
        .enforceReadPolicy(_$episodeLoadingStatusAtom);
    _$episodeLoadingStatusAtom.reportObserved();
    return super.episodeLoadingStatus;
  }

  @override
  set episodeLoadingStatus(EpisodeLoading value) {
    _$episodeLoadingStatusAtom.context.conditionallyRunInAction(() {
      super.episodeLoadingStatus = value;
      _$episodeLoadingStatusAtom.reportChanged();
    }, _$episodeLoadingStatusAtom,
        name: '${_$episodeLoadingStatusAtom.name}_set');
  }

  final _$_VideoPlayerStoreActionController =
      ActionController(name: '_VideoPlayerStore');

  @override
  dynamic setEpisodeLoadingStatus(EpisodeLoading status) {
    final _$actionInfo = _$_VideoPlayerStoreActionController.startAction();
    try {
      return super.setEpisodeLoadingStatus(status);
    } finally {
      _$_VideoPlayerStoreActionController.endAction(_$actionInfo);
    }
  }
}
