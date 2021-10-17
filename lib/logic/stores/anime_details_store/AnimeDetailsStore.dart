import 'dart:math';
import 'package:anime_app/logic/Constants.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'AnimeDetailsStore.g.dart';

enum TabChoice { EPISODES, RESUME }

class AnimeDetailsStore = _AnimeDetailsStore with _$AnimeDetailsStore;

abstract class _AnimeDetailsStore with Store {
  final ApplicationStore applicationStore;
  final AnimeItem currentAnimeItem;

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

    try {
      setLoadingStatus(LoadingStatus.LOADING);
      animeDetails =
          await applicationStore.getAnimeDetails(currentAnimeItem.id);
      setLoadingStatus(LoadingStatus.DONE);
      if (shouldLoadSuggestions) _loadAnimeSuggestions();
    } on CrawlerApiException catch (ex) {
      print(ex);
      setLoadingStatus(LoadingStatus.ERROR);
    }
  }

  String _generateQuery(List<String> data) {
    final generator = Random();
    var totalIndexes = generator.nextInt(data.length + 1);
    String query = '';

    for (var i = 0; i < totalIndexes; i++) {
      var index = generator.nextInt(data.length);
      query += '${data[index]}';
      data.removeAt(index);
    }

    return query;
  }

  void _loadAnimeSuggestions() {
    var genres = animeDetails.genre.split(',');
    var query =
        (genres.length > 3) ? _generateQuery(genres) : animeDetails.genre;

    applicationStore.api
        .search(
      query,
    )
        .then((animeListPage) {
      setRelatedAnimes(animeListPage.animes);
    }).catchError((error) {
      print(error);
      setRelatedAnimes([]);
    });
  }
}
