import 'package:anime_app/src/features/search/domain/model/search_page.dart';

abstract class SearchDataSource {
  Future<SearchPage> search({required String search, required int pageNumber});
}
