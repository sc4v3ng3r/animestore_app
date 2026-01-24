import 'package:anime_app/logic/Constants.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/src/core/domain/models/animestore_content_item.model.dart';
import 'package:anime_app/src/core/domain/models/content/animestore_content_settings.model.dart';
import 'package:anime_app/src/features/animestore_settings/domain/model/animestore_feature_settings.model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/domain/models/animestore_anime_details.model.dart';
import '../../../../core/domain/models/http/animestore_http_request.model.dart';
import '../../../../core/infrastructure/datasource/animestore_content_datasource.dart';

part 'anime_details_store.g.dart';

enum TabChoice { EPISODES, RESUME }

class AnimeDetailsStore = _AnimeDetailsStore with _$AnimeDetailsStore;

abstract class _AnimeDetailsStore with Store {
  late AnimestoreContentItem currentAnimeItem;
  final AnimestoreContentDatasource animeDetailsDatasource;

  @observable
  Color backgroundColor = imageBackgroundColor!;

  @observable
  LoadingStatus loadingStatus = LoadingStatus.NONE;

  @observable
  ObservableList<String> visualizedEps = ObservableList();

  @observable
  TabChoice tabChoice = TabChoice.EPISODES;

  late AnimestoreAnimeDetails animeDetails;

  @observable
  ObservableList<AnimestoreContentItem>? relatedAnimes;

  _AnimeDetailsStore(this.animeDetailsDatasource);

  @action
  setLoadingStatus(LoadingStatus data) => loadingStatus = data;

  @action
  addVisualizedEp(String episodeId) => visualizedEps.add(episodeId);

  @action
  setBackgroundColor(Color color) => backgroundColor = color;

  @action
  setTabChoice(TabChoice choice) => tabChoice = choice;

  // @action
  // setRelatedAnimes(List<AnimeItem> data) => relatedAnimes = ObservableList.of(
  //     data..removeWhere((item) => item.id.compareTo(currentAnimeItem.id) == 0));

  void loadAnimeDetails({
    required AnimestoreFeatureSettings featureSettings,
    required AnimestoreContentItem currentAnime,
    bool shouldLoadSuggestions = false,
  }) async {
    if (loadingStatus == LoadingStatus.LOADING) return;

    try {
      setLoadingStatus(LoadingStatus.LOADING);
      this.currentAnimeItem = currentAnime;

      final requestSettings = AnimeStoreRequestParametrizedBuilder.build(
          setting: featureSettings.apiSettings,
          pathParams: [currentAnimeItem.id]);

      animeDetails = await animeDetailsDatasource.exec(
          AnimeStoreContentSettingsImpl(
              declaration: featureSettings.parserDeclaration,
              request: requestSettings));
      setLoadingStatus(LoadingStatus.DONE);
      return;
    } on Exception catch (ex) {
      print(ex);
    }
    setLoadingStatus(LoadingStatus.ERROR);
  }

  // String _generateQuery(List<String> data) {
  //   final generator = Random();
  //   var totalIndexes = generator.nextInt(data.length + 1);
  //   String query = '';

  //   for (var i = 0; i < totalIndexes; i++) {
  //     var index = generator.nextInt(data.length);
  //     query += '${data[index]}';
  //     data.removeAt(index);
  //   }

  //   return query;
  // }

  // void _loadAnimeSuggestions() {
  //   var genres = animeDetails.genre.split(',');
  //   var query =
  //       (genres.length > 3) ? _generateQuery(genres) : animeDetails.genre;

  //   applicationStore.api
  //       .search(
  //     query,
  //   )
  //       .then((animeListPage) {
  //     setRelatedAnimes(animeListPage.animes);
  //   }).catchError((error) {
  //     print(error);
  //     setRelatedAnimes([]);
  //   });
  // }
}
