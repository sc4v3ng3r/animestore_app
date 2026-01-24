import 'package:get_it/get_it.dart';

import '../../../../logic/stores/application/ApplicationStore.dart';
import '../presenter/controller/search_store.dart';
import '../../../core/infrastructure/di/animestore_dependecy_injector.dart';
import '../../anitube/external/datasource/anitube_anime_list_datasource.impl.dart';

class SearchDependencyInjector extends AnimestoreDependecyInjector {
  final GetIt _getIt;

  SearchDependencyInjector(this._getIt);

  @override
  void inject() {
    if (!_getIt.isRegistered<SearchStore>()) {
      _getIt.registerFactory<SearchStore>(() => SearchStore(
          _getIt<ApplicationStore>(),
          _getIt<AnitubeAnimeListDatasourceImpl>()));
    }
  }
}
