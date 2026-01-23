import 'package:get_it/get_it.dart';
import '../../../core/infrastructure/di/animestore_dependecy_injector.dart';
import '../../anitube/external/datasource/anitube_anime_feed_datasource.impl.dart';
import '../presenter/controller/anime_feed_controller.dart';

class AnimeFeedDependencyInjector extends AnimestoreDependecyInjector {
  final GetIt _getIt;

  AnimeFeedDependencyInjector(this._getIt);

  @override
  void inject() {
    if (!_getIt.isRegistered<AnimeFeedController>()) {
      _getIt.registerFactory(
          () => AnimeFeedController(_getIt<AnitubeAnimeFeedDatasourceImpl>()));
    }
  }
}
