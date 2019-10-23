import 'package:rxdart/rxdart.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';


enum SearchStatus {SEARCHING, DONE, NONE}

class ApplicationBloc {
  static const DEFAULT_PAGES_LOADING = 4;
  static const TIMEOUT = 10000;
  final AniTubeApi api = AniTubeApi();

  final BehaviorSubject< List<AnimeItem> > _animesSubject = BehaviorSubject();
  Observable< List<AnimeItem> > get animesObservable => _animesSubject.stream;

  final BehaviorSubject<bool> _isLoadingSubject = BehaviorSubject();
  Observable<bool> get isLoading => _isLoadingSubject.stream;

  final BehaviorSubject<SearchStatus> _searchSubject = BehaviorSubject.seeded(SearchStatus.NONE);
  Observable<SearchStatus> get searchStatus => _searchSubject.stream;

  final BehaviorSubject<bool> _isSearchingMoreSubject = BehaviorSubject();
  Observable<bool> get isSearchingMore => _isSearchingMoreSubject.stream;

  final BehaviorSubject<String> _searchTextSubject = BehaviorSubject();
  Observable<String> get searchStream => _searchTextSubject.stream;

  int listCurrentPage = 1;
  int maxAnimeListPageNumber = 1;
  List<AnimeItem> animeDataList = [];

  int searchPageCounter = 1;
  int maxSearchPageNumber = 1;
  List<AnimeItem> searchDataList = [];
  String _lastSearch = '';

  bool _isLoading = false;
  bool _isSearchingMore = false;

  int get totalItems => animeDataList.length;

  void _addToSink( List<AnimeItem> data) => _animesSubject.sink.add( data );

  void _addToSearchSink(SearchStatus status) => _searchSubject.sink.add(status);
  void _setIsSearchingMore(bool flag) {
    _isSearchingMore = flag;
    _isSearchingMoreSubject.sink.add(flag);
  }

  Future<bool> init() async {
    var flag = false;
    try {
      await loadData();
      flag =  true;
    }
    catch (ex){
      flag= false;

    }

    return flag;
  }

  void _setIsLoading(bool flag) {
      _isLoading = flag;
    _isLoadingSubject.sink.add(_isLoading);
  }

  Future<void> loadData() async {
    if (_isLoading == true)
      return;

    _setIsLoading(true);

    for(int i = 0; i < DEFAULT_PAGES_LOADING; i++) {
      if (listCurrentPage <= maxAnimeListPageNumber){
        try {
          var data = await api.getAnimeListPageData(pageNumber: listCurrentPage);
          animeDataList.addAll(  data.animes );
          maxAnimeListPageNumber = int.parse( data.maxPageNumber );
          listCurrentPage++;
        }
        on CrawlerApiException catch(ex){
          //_addToSink(_dataList);
          print('Fail loding page number $listCurrentPage $ex' );
          listCurrentPage++;
          //_addError(ex);
        }

      }
    }

    _addToSink(animeDataList);
    _setIsLoading(false);
    print('loading done');
  }

  Future<AnimeDetails> getAnimeDetails(String id) => api.getAnimeDetails(id, timeout: TIMEOUT);

  Future<EpisodeDetails> getEpisodeDetails(String id) => api.getEpisodeDetails(id, timeout: TIMEOUT);

  Future<void> search(String search) async {
    if (_isSearchingMore)
      return;

    _lastSearch = search;
    searchDataList.clear();
    searchPageCounter = 1;
    _searchTextSubject.sink.add(_lastSearch);

    try {
      _addToSearchSink(SearchStatus.SEARCHING);
      var searchPage = await api.search(search, timeout: TIMEOUT, pageNumber: searchPageCounter);
      maxSearchPageNumber = int.parse(searchPage.maxPageNumber);
      searchDataList.addAll(  searchPage.animes );
      searchPageCounter++;

      // Could that condition generate an error or bad behavior?
      if (searchPageCounter <= maxSearchPageNumber ){
        var searchPage = await api.search(search,
            timeout: TIMEOUT,
            pageNumber: searchPageCounter
        );
        searchDataList.addAll(  searchPage.animes );
        searchPageCounter++;
      }

    }
    catch (ex){
      print('Error doing search! $ex');
    }

    _addToSearchSink(SearchStatus.DONE);
  }

  Future<void> paginateLastSearch() async {
    if (_isSearchingMore)
      return;

    _setIsSearchingMore(true);

    if (searchPageCounter <= maxSearchPageNumber){

        try {
          var data = await api.search(_lastSearch, timeout: TIMEOUT, pageNumber: searchPageCounter);
          searchDataList.addAll(  data.animes );
          searchPageCounter++;

          data = await api.search(_lastSearch, timeout: TIMEOUT, pageNumber: searchPageCounter);
          searchDataList.addAll(  data.animes );
          searchPageCounter++;
        }
        on CrawlerApiException catch(ex){
          print('Exception loading pagination search $ex');
          searchPageCounter++;
        }
      }

    print('Current page $searchPageCounter');

    _addToSearchSink(SearchStatus.DONE);
    _setIsSearchingMore(false);
  }

  void clearSearchResults() {
    searchDataList.clear();
    _lastSearch = '';
    searchPageCounter = 1;
    _addToSearchSink(SearchStatus.NONE);
    _searchTextSubject.sink.add(_lastSearch);
  }

  void dispose(){
    _searchTextSubject?.close();
    _isLoadingSubject.drain().then( (_) => _isLoadingSubject.close() );
    _animesSubject.drain().then((_) => _animesSubject.close() );
    _searchSubject.drain().then((_)  => _searchSubject.close());
    _isSearchingMoreSubject.drain((_)  => _isSearchingMoreSubject.close());
  }

}