import 'package:anime_app/src/features/error/failure/animeapp_failure.dart';
import 'package:anime_app/src/features/search/domain/model/search_page.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<AnimeappFailure, SearchPage>> search(
      {required String query, required int pageNumber});
}
