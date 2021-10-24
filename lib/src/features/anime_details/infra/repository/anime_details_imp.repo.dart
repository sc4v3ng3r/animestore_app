import 'package:anime_app/src/features/anime_details/domain/repository/anime_details.repo.dart';
import 'package:anime_app/src/features/anime_details/infra/datasource/anime_details_datasource.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:dartz/dartz.dart';
import 'package:anime_app/src/features/error/failure/animeapp_failure.dart';

class AnimeDetailsRepositoryImp extends AnimeDetailsRepository {
  final AnimeDetailsDataSource datasource;

  AnimeDetailsRepositoryImp(this.datasource);

  @override
  Future<Either<AnimeappFailure, AnimeDetails>> getAnimeDetails(
      {required String animeId}) async {
    AnimeappFailure failure;
    try {
      final response = await datasource.getAnimeDetails(animeId: animeId);
      return Right(response);
    } catch (ex) {
      failure = NetworkFailure(ex.toString());
    }
    return Left(failure);
  }
}
