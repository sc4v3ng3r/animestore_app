import 'package:anime_app/src/features/anime_details/domain/repository/anime_details.repo.dart';
import 'package:anime_app/src/features/anime_details/domain/usecase/anime_details_usecase.dart';
import 'package:anime_app/src/features/anime_details/external/anime_details_datasource.imp.dart';
import 'package:anime_app/src/features/anime_details/infra/datasource/anime_details_datasource.dart';
import 'package:anime_app/src/features/anime_details/infra/repository/anime_details_imp.repo.dart';
import 'package:anime_app/src/features/search/domain/repository/isearch_repository.dart';
import 'package:anime_app/src/features/search/domain/usecase/search_usecase.dart';
import 'package:anime_app/src/features/search/external/search_datasource.imp.dart';
import 'package:anime_app/src/features/search/infra/datasource/isearch_datasource.dart';
import 'package:anime_app/src/features/search/infra/repository/search_repository.imp.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DepedencyInjection {
  void registerDependencies() {
    _initHttpDependencies();

    // modules
    _initSearchModuleDepencies();
    _registerAnimeDetailsDependencies();
  }

  void _initHttpDependencies() {
    getIt.registerLazySingleton<AniTubeApi>(() => AniTubeApi(Dio()));
  }

  void _initSearchModuleDepencies() {
    getIt.registerFactory<SearchDataSource>(() => SearchDatasourceImp(getIt()));
    getIt.registerFactory<SearchRepository>(() => SearchRepositoryImp(getIt()));
    getIt.registerFactory<SearchUseCase>(() => SearchUseCaseImp(getIt()));
  }

  void _registerAnimeDetailsDependencies() {
    getIt.registerFactory<AnimeDetailsDataSource>(
        () => AnimeDetailsDatasourceImp(getIt()));
    getIt.registerFactory<AnimeDetailsRepository>(
        () => AnimeDetailsRepositoryImp(getIt()));
    getIt.registerFactory<AnimeDetailsReadUsecase>(
        () => AnimeDetailsReadUsecaseImp(getIt()));
    getIt.registerFactory<AnieDetailsReadRelatedUsecase>(
        () => AnieDetailsReadRelatedUsecaseImp(getIt()));
  }
}
