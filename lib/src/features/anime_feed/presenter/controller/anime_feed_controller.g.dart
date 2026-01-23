// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_feed_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnimeFeedController on _AnimeFeedController, Store {
  late final _$statusAtom =
      Atom(name: '_AnimeFeedController.status', context: context);

  @override
  LoadingStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(LoadingStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$animeFeedListAtom =
      Atom(name: '_AnimeFeedController.animeFeedList', context: context);

  @override
  List<AnimestoreContentItem> get animeFeedList {
    _$animeFeedListAtom.reportRead();
    return super.animeFeedList;
  }

  @override
  set animeFeedList(List<AnimestoreContentItem> value) {
    _$animeFeedListAtom.reportWrite(value, super.animeFeedList, () {
      super.animeFeedList = value;
    });
  }

  late final _$_AnimeFeedControllerActionController =
      ActionController(name: '_AnimeFeedController', context: context);

  @override
  void setStatus(LoadingStatus status) {
    final _$actionInfo = _$_AnimeFeedControllerActionController.startAction(
        name: '_AnimeFeedController.setStatus');
    try {
      return super.setStatus(status);
    } finally {
      _$_AnimeFeedControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAnimeToList(List<AnimestoreContentItem> animeList) {
    final _$actionInfo = _$_AnimeFeedControllerActionController.startAction(
        name: '_AnimeFeedController.addAnimeToList');
    try {
      return super.addAnimeToList(animeList);
    } finally {
      _$_AnimeFeedControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
animeFeedList: ${animeFeedList}
    ''';
  }
}
