import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/src/core/domain/models/content/animestore_content_settings.model.dart';
import 'package:anime_app/src/core/domain/models/features/animestore_features.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/domain/models/animestore_content_item.model.dart';
import '../../../../core/domain/models/content/animestore_content_feed_page.model.dart';
import '../../../../core/domain/models/http/animestore_http_request.model.dart';
import '../../../../core/infrastructure/datasource/animestore_content_datasource.dart';

part 'search_store.g.dart';

enum SearchState { SEARCHING, DONE, ERROR, NONE }

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  static const PAGE_LOAD_NUMBER = 2;

  final ApplicationStore applicationStore;
  final AnimestoreContentDatasource<
          Future<AnimestoreContentFeedPage<List<AnimestoreContentItem>>>>
      _animesDataSource;

  String currentQuery = '';

  int _pageNumberToLoad = 1;
  int _maxPageNumber = 1;
  double searchListOffset = .0;

  @observable
  bool isLoadingMore = false;

  @observable
  ObservableList<AnimestoreContentItem> searchItemList = ObservableList();

  @observable
  SearchState searchState = SearchState.NONE;

  _SearchStore(this.applicationStore, this._animesDataSource);

  //@action setQueryText(String text) => currentQuery = text;

  @action
  setLoadingMore(bool flag) => isLoadingMore = flag;

  @action
  addSearchItemList(List<AnimestoreContentItem> data) =>
      searchItemList.addAll(data);

  @action
  setSearchItems(List<AnimestoreContentItem> data) =>
      searchItemList = ObservableList.of(data);

  @action
  setSearchStatus(SearchState state) => searchState = state;

  @action
  clearSearchItems() => searchItemList.clear();

  @action
  clearSearch() {
    currentQuery = '';
    setSearchItems([]); // try clear method
    _pageNumberToLoad = 1;
    _maxPageNumber = 1;
    searchListOffset = .0;
    setSearchStatus(SearchState.NONE);
  }

  void search(String search) async {
    if (searchState == SearchState.SEARCHING) return;

    this.currentQuery = search;
    clearSearchItems();
    _pageNumberToLoad = 1;
    _maxPageNumber = 1;

    try {
      setSearchStatus(SearchState.SEARCHING);
      List<AnimestoreContentItem> results = [];

      if (_pageNumberToLoad <= _maxPageNumber) {
        var pageInfo = await _loadData(currentQuery, _pageNumberToLoad);
        _pageNumberToLoad++;
        _maxPageNumber = pageInfo.maxPage;

        results.addAll(pageInfo.content);

        if ((_pageNumberToLoad + PAGE_LOAD_NUMBER) <= _maxPageNumber) {
          for (var i = 0; i < PAGE_LOAD_NUMBER; i++) {
            var pageData = await _loadData(currentQuery, _pageNumberToLoad);
            _pageNumberToLoad++;
            results.addAll(pageData.content);
          }
        }
        setSearchItems(results);
      }

      setSearchStatus(SearchState.DONE);
    } on Exception catch (ex) {
      print(ex);
      setSearchStatus(SearchState.ERROR);
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore) return;

    if (_pageNumberToLoad <= _maxPageNumber) {
      try {
        setLoadingMore(true);
        List<AnimestoreContentItem> results = [];

        for (var i = 0; i < 2; i++) {
          var pageData = await _loadData(currentQuery, _pageNumberToLoad);
          _pageNumberToLoad++;
          results.addAll(pageData.content);
        }
        setLoadingMore(false);
        this.addSearchItemList(results);
      } on Exception catch (ex) {
        print(ex);
        setLoadingMore(false);
      }
    }
  }

  Future<AnimestoreContentFeedPage> _loadData(String query, int number) {
    final featureSettings =
        applicationStore.getFeatureSettings(AnimestoreFeature.animeSearch);

    return _animesDataSource.exec(AnimeStoreContentSettingsImpl(
        declaration: featureSettings.parserDeclaration,
        request: AnimeStoreRequestParametrizedBuilder.build(
            setting: featureSettings.apiSettings,
            queryParams: [query],
            pathParams: ['$number'])));
    // var searchPage;
    // if (query.length == 1)
    //   searchPage = await applicationStore.api.getAnimeListPageData(
    //     startsWith: query,
    //     pageNumber: number,
    //   );
    // else
    //   searchPage = await applicationStore.api.search(query, pageNumber: number);

    // return searchPage;
  }
}
