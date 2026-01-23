import 'package:mobx/mobx.dart';

import '../../../../../logic/stores/StoreUtils.dart';
import '../../../../core/domain/models/animestore_content_item.model.dart';
import '../../../../core/domain/models/content/animestore_content_feed_page.model.dart';
import '../../../../core/domain/models/content/animestore_content_settings.model.dart';
import '../../../../core/domain/models/http/animestore_http_request.model.dart';
import '../../../../core/infrastructure/datasource/animestore_content_datasource.dart';
import '../../../animestore_settings/domain/model/animestore_feature_settings.model.dart';

part 'anime_feed_controller.g.dart';

class AnimeFeedController = _AnimeFeedController with _$AnimeFeedController;

abstract class _AnimeFeedController with Store {
  AnimestoreContentDatasource<
          Future<AnimestoreContentFeedPage<List<AnimestoreContentItem>>>>
      dataSource;

  int _mainAnimesPageCounter = 1;
  int _maxMainAnimesPageNumber = 1;
  double mainAnimeListOffset = .0;

  _AnimeFeedController(this.dataSource);

  @observable
  LoadingStatus status = LoadingStatus.NONE;

  @observable
  List<AnimestoreContentItem> animeFeedList = ObservableList();

  @action
  void setStatus(LoadingStatus status) => this.status = status;

  @action
  void addAnimeToList(List<AnimestoreContentItem> animeList) =>
      this.animeFeedList.addAll(animeList);

  Future<void> loadAnimeList(
      {required AnimestoreFeatureSettings featureSettings}) async {
    if (status == LoadingStatus.LOADING) return;

    final cacheList = <AnimestoreContentItem>[];

    if (_mainAnimesPageCounter <= _maxMainAnimesPageNumber) {
      setStatus(LoadingStatus.LOADING);

      for (int i = 1; i <= 3; i++) {
        try {
          var data = await dataSource.exec(AnimeStoreContentSettingsImpl(
              declaration: featureSettings.parserDeclaration,
              request: AnimeStoreRequestParametrizedBuilder.build(
                setting: featureSettings.apiSettings,
                pathParams: ['$_mainAnimesPageCounter'],
              )));

          cacheList.addAll(data.content);

          _maxMainAnimesPageNumber = data.maxPage;
          _mainAnimesPageCounter++;
        } catch (ex) {
          print('Fail loding page number $_mainAnimesPageCounter $ex');
          _mainAnimesPageCounter++;
        }
      }
    }

    addAnimeToList(cacheList);
    setStatus(LoadingStatus.DONE);
  }
}
