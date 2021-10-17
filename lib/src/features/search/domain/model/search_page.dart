import 'package:anitube_crawler_api/anitube_crawler_api.dart';

class SearchPage {
  final List<AnimeItem> results;
  final int pageNumber;
  final int maxPageNumber;

  SearchPage(
      {required this.results, this.pageNumber = 0, this.maxPageNumber = 0});
}
