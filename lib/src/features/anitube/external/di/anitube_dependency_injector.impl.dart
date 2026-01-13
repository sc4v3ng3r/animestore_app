import 'package:get_it/get_it.dart';

import '../../../../core/external/http/animestore_http_client.impl.dart';
import '../../../../core/external/parser/animestore_html_parser.impl.dart';
import '../../../../core/infrastructure/di/animestore_dependecy_injector.dart';
import '../datasource/anitube_anime_details_datasource.impl.dart';
import '../datasource/anitube_home_datasource.impl.dart';

class AnitubeDependencyInjector extends AnimestoreDependecyInjector {
  final GetIt _getIt;

  AnitubeDependencyInjector(this._getIt);

  @override
  void inject() {
    if (!_getIt.isRegistered<AnitubeHomeDatasourceImpl>()) {
      _getIt.registerFactory<AnitubeHomeDatasourceImpl>(() =>
          AnitubeHomeDatasourceImpl(_getIt<AnimestoreHttpClientImpl>(),
              _getIt<AnimestoreHtmlParserImpl>()));
    }

    if (!_getIt.isRegistered<AnitubeAnimeDetailsDatasourceImpl>()) {
      _getIt.registerFactory<AnitubeAnimeDetailsDatasourceImpl>(() =>
          AnitubeAnimeDetailsDatasourceImpl(_getIt<AnimestoreHttpClientImpl>(),
              _getIt<AnimestoreHtmlParserImpl>()));
    }
  }
}
