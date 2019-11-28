import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:mobx/mobx.dart';

part 'GenreAnimeStore.g.dart';

//class AnimeDetailsStore = _AnimeDetailsStore with _$AnimeDetailsStore;
class GenreAnimeStore = _GenreAnimeStore with _$GenreAnimeStore;

abstract class _GenreAnimeStore with Store {
  final ApplicationStore _appStore;
  final String genre;
  static const PAGE_LOAD_NUMBER = 2;

  int _currentPageNumber = 1;
  int _maxPageNumber = 1;

  _GenreAnimeStore(ApplicationStore appStore, this.genre) : _appStore = appStore;

  @observable
  ObservableList<AnimeItem> animeItems = ObservableList();

  @observable
  LoadingStatus loadingStatus = LoadingStatus.LOADING;

  @observable
  bool isLoadingMore = false;

  @action
  setIsLoadingMore(bool flag) => isLoadingMore = flag;

  @action
  setLoadingStatus(LoadingStatus data) => loadingStatus = data;

  @action
  setAnimesItem(List<AnimeItem> data) => animeItems = ObservableList.of(data);

  @action
  addAnimeItems(List<AnimeItem> data) => animeItems.addAll(data);


  void init() async {

    try {
      List<AnimeItem> results = [];

      if (_currentPageNumber <= _maxPageNumber){
        var pageInfo = await _loadData(this.genre,_currentPageNumber );
        _currentPageNumber++;
        _maxPageNumber = int.parse( pageInfo.maxPageNumber );

        results.addAll( pageInfo.animes );

        if ((_currentPageNumber + PAGE_LOAD_NUMBER ) <= _maxPageNumber ){
          for(var i=0 ; i < PAGE_LOAD_NUMBER; i++){
            var pageData = await _loadData(this.genre, _currentPageNumber);
            _currentPageNumber++;
            results.addAll( pageData.animes );
          }
        }
        setAnimesItem(results);
      }

      setLoadingStatus(LoadingStatus.DONE);
    }
    on CrawlerApiException catch(ex){
      print(ex);
      setLoadingStatus(LoadingStatus.ERROR);
    }
  }


  Future<void> loadMore() async {
    if (isLoadingMore)
      return;

    if (_currentPageNumber <= _maxPageNumber){
      try {
        setIsLoadingMore(true);
        List<AnimeItem> results = [];

        for(var i=0 ; i < PAGE_LOAD_NUMBER; i++){
          var pageData = await _loadData(this.genre, _currentPageNumber);
          _currentPageNumber++;
          results.addAll( pageData.animes );
        }

        setIsLoadingMore(false);
        addAnimeItems(results);
      }

      on CrawlerApiException catch(ex){
        print(ex);
        setIsLoadingMore(false);
      }
    }

  }

  Future< AnimeListPageInfo > _loadData(String query, int number) async {
    var searchPage;
    searchPage = await _appStore.api.search(query, pageNumber: number);
    return searchPage;
  }

}