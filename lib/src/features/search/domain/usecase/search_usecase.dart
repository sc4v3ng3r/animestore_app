import 'package:anime_app/src/features/error/failure/animeapp_failure.dart';
import 'package:anime_app/src/features/search/domain/model/search_page.dart';
import 'package:anime_app/src/features/search/domain/repository/isearch_repository.dart';
import 'package:dartz/dartz.dart';

abstract class SearchUseCase {
  Future<Either<AnimeappFailure, SearchPage>> search(
      {required String query, required int pageNumber});
}

class SearchUseCaseImp extends SearchUseCase {
  final SearchRepository repository;

  SearchUseCaseImp(this.repository);

  @override
  Future<Either<AnimeappFailure, SearchPage>> search(
          {required String query, required int pageNumber}) =>
      repository.search(query: query, pageNumber: pageNumber);
}
