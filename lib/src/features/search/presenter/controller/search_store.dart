import 'package:anime_app/src/features/search/domain/usecase/search_usecase.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:mobx/mobx.dart';

part 'search_store.g.dart';

enum SearchState { SEARCHING, DONE, ERROR, NONE }

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  static const PAGE_LOAD_NUMBER = 2;
  final SearchUseCase searchUseCase;

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

  _SearchStore(this.searchUseCase);

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

    setSearchStatus(SearchState.SEARCHING);
    List<AnimeItem>? results;

    if (_pageNumberToLoad <= _maxPageNumber) {
      var useCaseData = await searchUseCase.search(
          query: currentQuery, pageNumber: _pageNumberToLoad);

      _pageNumberToLoad++;
      useCaseData.fold((l) => null, (success) {
        results ??= [];
        _maxPageNumber = success.maxPageNumber;
        results!.addAll(success.results);
      });

      if ((_pageNumberToLoad + PAGE_LOAD_NUMBER) <= _maxPageNumber) {
        for (var i = 0; i < PAGE_LOAD_NUMBER; i++) {
          var useCaseData = await searchUseCase.search(
              query: currentQuery, pageNumber: _pageNumberToLoad);
          _pageNumberToLoad++;

          useCaseData.fold((l) => null, (success) {
            results ??= [];
            results!.addAll(success.results);
          });
        }
      }
    }
    if (results != null) {
      setSearchItems(results!);
      setSearchStatus(SearchState.DONE);
    } else
      setSearchStatus(SearchState.ERROR);
  }

  Future<void> loadMore() async {
    if (isLoadingMore) return;

    if (_pageNumberToLoad <= _maxPageNumber) {
      setLoadingMore(true);
      List<AnimeItem> results = [];

      for (var i = 0; i < 2; i++) {
        var pageData = await searchUseCase.search(
            query: currentQuery, pageNumber: _pageNumberToLoad);
        _pageNumberToLoad++;
        pageData.fold((l) => null, (right) {
          results.addAll(right.results);
        });
      }
      setLoadingMore(false);
      this.addSearchItemList(results);
    }
  }
}
