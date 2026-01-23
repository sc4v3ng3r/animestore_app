import 'package:anime_app/src/core/infrastructure/di/animestore_dependecy_injector.dart';
import 'package:get_it/get_it.dart';

import '../presenter/controller/anime_details_store.dart';
import '../../anitube/external/datasource/anitube_anime_details_datasource.impl.dart';

class AnimeDetailsDepdencyInjector extends AnimestoreDependecyInjector {
  final GetIt _getIt;

  AnimeDetailsDepdencyInjector(this._getIt);
  @override
  void inject() {
    if (!_getIt.isRegistered<AnimeDetailsStore>()) {
      _getIt.registerFactory<AnimeDetailsStore>(
          () => AnimeDetailsStore(_getIt<AnitubeAnimeDetailsDatasourceImpl>()));
    }
  }
}
