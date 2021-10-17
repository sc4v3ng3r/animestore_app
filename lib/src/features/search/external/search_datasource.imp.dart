import 'package:anime_app/src/features/error/exception/animeapp_exception.dart';
import 'package:anime_app/src/features/search/domain/model/search_page.dart';
import 'package:anime_app/src/features/search/infra/datasource/isearch_datasource.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';

class SearchDatasourceImp extends SearchDataSource {
  final AniTubeApi api;

  SearchDatasourceImp(this.api);

  @override
  Future<SearchPage> search(
      {required String search, required int pageNumber}) async {
    try {
      final searchPage = await api.search(search, pageNumber: pageNumber);

      return SearchPage(
          results: searchPage.animes,
          pageNumber: int.parse(searchPage.pageNumber),
          maxPageNumber: int.parse(searchPage.maxPageNumber));
    } on CrawlerApiException catch (exception) {
      print(
          "SearchDatasourceImp::search ${exception.message}|${exception.errorType}");
      throw AppNetworkExpcetion(message: "", code: 700);
    } catch (ex) {
      print(ex);
      throw AppExecutionException();
    }
  }
}
