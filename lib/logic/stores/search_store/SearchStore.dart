import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:mobx/mobx.dart';

part 'SearchStore.g.dart';

enum SearchState { SEARCHING, DONE, ERROR, NONE }

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  static const PAGE_LOAD_NUMBER = 2;

  final ApplicationStore applicationStore;

  String currentQuery = '';

  int _pageNumberToLoad = 1;
  int _maxPageNumber = 1;
  double searchListOffset = .0;

  @observable
  bool isLoadingMore = false;

  @observable
  ObservableList<AnimeItem> searchItemList = ObservableList();

  @observable
  SearchState searchState = SearchState.NONE;

  _SearchStore(this.applicationStore);

  //@action setQueryText(String text) => currentQuery = text;

  @action
  setLoadingMore(bool flag) => isLoadingMore = flag;

  @action
  addSearchItemList(List<AnimeItem> data) => searchItemList.addAll(data);

  @action
  setSearchItems(List<AnimeItem> data) =>
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
      List<AnimeItem> results = [];

      if (_pageNumberToLoad <= _maxPageNumber) {
        var pageInfo = await _loadData(currentQuery, _pageNumberToLoad);
        _pageNumberToLoad++;
        _maxPageNumber = int.parse(pageInfo.maxPageNumber);

        results.addAll(pageInfo.animes);

        if ((_pageNumberToLoad + PAGE_LOAD_NUMBER) <= _maxPageNumber) {
          for (var i = 0; i < PAGE_LOAD_NUMBER; i++) {
            var pageData = await _loadData(currentQuery, _pageNumberToLoad);
            _pageNumberToLoad++;
            results.addAll(pageData.animes);
          }
        }
        setSearchItems(results);
      }

      setSearchStatus(SearchState.DONE);
    } on CrawlerApiException catch (ex) {
      print(ex);
      setSearchStatus(SearchState.ERROR);
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore) return;

    if (_pageNumberToLoad <= _maxPageNumber) {
      try {
        setLoadingMore(true);
        List<AnimeItem> results = [];

        for (var i = 0; i < 2; i++) {
          var pageData = await _loadData(currentQuery, _pageNumberToLoad);
          _pageNumberToLoad++;
          results.addAll(pageData.animes);
        }
        setLoadingMore(false);
        this.addSearchItemList(results);
      } on CrawlerApiException catch (ex) {
        print(ex);
        setLoadingMore(false);
      }
    }
  }

  Future<AnimeListPageInfo> _loadData(String query, int number) async {
    var searchPage;
    if (query.length == 1)
      searchPage = await applicationStore.api.getAnimeListPageData(
        startsWith: query,
        pageNumber: number,
      );
    else
      searchPage = await applicationStore.api.search(query, pageNumber: number);

    return searchPage;
  }
}
