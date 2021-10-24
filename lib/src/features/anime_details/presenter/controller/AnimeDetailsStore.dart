import 'package:anime_app/logic/Constants.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/src/features/anime_details/domain/usecase/anime_details_usecase.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'AnimeDetailsStore.g.dart';

enum TabChoice { EPISODES, RESUME }

class AnimeDetailsStore = _AnimeDetailsStore with _$AnimeDetailsStore;

abstract class _AnimeDetailsStore with Store {
  final ApplicationStore applicationStore;
  final AnimeItem currentAnimeItem;
  final AnimeDetailsReadUsecase detailsReadUsecase;
  final AnieDetailsReadRelatedUsecase readRelatedUsecase;

  /// if the component should load anime suggestions
  final bool shouldLoadSuggestions;

  @observable
  Color backgroundColor = imageBackgroundColor!;

  @observable
  LoadingStatus loadingStatus = LoadingStatus.NONE;

  @observable
  ObservableList<String> visualizedEps = ObservableList();

  @observable
  TabChoice tabChoice = TabChoice.EPISODES;

  late AnimeDetails animeDetails;

  @observable
  ObservableList<AnimeItem>? relatedAnimes;

  _AnimeDetailsStore(this.applicationStore, this.currentAnimeItem,
      this.detailsReadUsecase, this.readRelatedUsecase,
      {this.shouldLoadSuggestions = true});

  @action
  setLoadingStatus(LoadingStatus data) => loadingStatus = data;

  @action
  addVisualizedEp(String episodeId) => visualizedEps.add(episodeId);

  @action
  setBackgroundColor(Color color) => backgroundColor = color;

  @action
  setTabChoice(TabChoice choice) => tabChoice = choice;

  @action
  setRelatedAnimes(List<AnimeItem> data) => relatedAnimes = ObservableList.of(
      data..removeWhere((item) => item.id.compareTo(currentAnimeItem.id) == 0));

  void loadAnimeDetails() async {
    if (loadingStatus == LoadingStatus.LOADING) return;

    setLoadingStatus(LoadingStatus.LOADING);
    final response = await this
        .detailsReadUsecase
        .readAnimeDetails(animeId: currentAnimeItem.id);

    response.fold((left) => setLoadingStatus(LoadingStatus.ERROR), (right) {
      animeDetails = right;
      setLoadingStatus(LoadingStatus.DONE);
      if (shouldLoadSuggestions) _loadAnimeSuggestions();
    });
  }

  void _loadAnimeSuggestions() {
    this
        .readRelatedUsecase
        .searchAnimeRealted(detais: animeDetails)
        .then((value) {
      value.fold((failure) => setRelatedAnimes([]),
          (sucessData) => setRelatedAnimes(sucessData));
    });
  }
}
