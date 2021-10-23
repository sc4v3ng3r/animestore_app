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
    _initSearchModuleDepencies();
  }

  void _initHttpDependencies() {
    getIt.registerLazySingleton<AniTubeApi>(() => AniTubeApi(Dio()));
  }

  void _initSearchModuleDepencies() {
    getIt.registerFactory<SearchDataSource>(() => SearchDatasourceImp(getIt()));
    getIt.registerFactory<SearchRepository>(() => SearchRepositoryImp(getIt()));
    getIt.registerFactory<SearchUseCase>(() => SearchUseCaseImp(getIt()));
  }
}
