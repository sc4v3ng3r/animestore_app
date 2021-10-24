import 'package:anime_app/src/features/error/failure/animeapp_failure.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:dartz/dartz.dart';

abstract class AnimeDetailsRepository {
  Future<Either<AnimeappFailure, AnimeDetails>> getAnimeDetails(
      {required String animeId});
}
