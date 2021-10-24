import 'package:anitube_crawler_api/anitube_crawler_api.dart';

abstract class AnimeDetailsDataSource {
  Future<AnimeDetails> getAnimeDetails({required String animeId});
  // Future<List> getAnimeRelated({required animeId});
}
