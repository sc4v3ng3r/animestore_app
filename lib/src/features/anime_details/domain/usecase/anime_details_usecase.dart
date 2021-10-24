import 'dart:math';

import 'package:anime_app/src/features/anime_details/domain/repository/anime_details.repo.dart';
import 'package:anime_app/src/features/error/failure/animeapp_failure.dart';
import 'package:anime_app/src/features/search/domain/repository/isearch_repository.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:dartz/dartz.dart';

abstract class AnimeDetailsReadUsecase {
  Future<Either<AnimeappFailure, AnimeDetails>> readAnimeDetails(
      {required String animeId});
}

abstract class AnieDetailsReadRelatedUsecase {
  Future<Either<AnimeappFailure, List<AnimeItem>>> searchAnimeRealted(
      {required AnimeDetails detais});
}

// implementations

class AnimeDetailsReadUsecaseImp extends AnimeDetailsReadUsecase {
  final AnimeDetailsRepository detailsRepository;
  AnimeDetailsReadUsecaseImp(
    this.detailsRepository,
  );

  @override
  Future<Either<AnimeappFailure, AnimeDetails>> readAnimeDetails(
      {required String animeId}) async {
    final response = await detailsRepository.getAnimeDetails(animeId: animeId);
    return response;
  }
}

class AnieDetailsReadRelatedUsecaseImp extends AnieDetailsReadRelatedUsecase {
  final SearchRepository searchRepository;

  AnieDetailsReadRelatedUsecaseImp(this.searchRepository);

  @override
  Future<Either<AnimeappFailure, List<AnimeItem>>> searchAnimeRealted(
      {required AnimeDetails detais}) async {
    var genres = detais.genre.split(',');
    var query = (genres.length > 3) ? _generateQuery(genres) : detais.genre;

    final data = await searchRepository.search(query: query, pageNumber: 1);
    return data.fold((l) => Left(l), (r) => Right(r.results));
  }

  String _generateQuery(List<String> data) {
    final generator = Random();
    var totalIndexes = generator.nextInt(data.length + 1);
    String query = '';

    for (var i = 0; i < totalIndexes; i++) {
      var index = generator.nextInt(data.length);
      query += '${data[index]}';
      data.removeAt(index);
    }

    return query;
  }
}
