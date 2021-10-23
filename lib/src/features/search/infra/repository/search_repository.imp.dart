import 'package:anime_app/src/features/search/domain/model/search_page.dart';
import 'package:anime_app/src/features/error/failure/animeapp_failure.dart';
import 'package:anime_app/src/features/search/domain/repository/isearch_repository.dart';
import 'package:anime_app/src/features/search/infra/datasource/isearch_datasource.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImp extends SearchRepository {
  final SearchDataSource dataSource;
  SearchRepositoryImp(this.dataSource);

  @override
  Future<Either<AnimeappFailure, SearchPage>> search(
      {required String query, required int pageNumber}) async {
    AnimeappFailure failure;
    try {
      final data = (query.length == 1)
          ? await dataSource.searchWhereStartsWith(
              search: query, pageNumber: pageNumber)
          : await dataSource.search(search: query, pageNumber: pageNumber);

      return Right(data);
    } catch (ex) {
      failure = SearchFailure(message: "Wasn\'t possible searhc $query");
    }
    return Left(failure);
  }
}
