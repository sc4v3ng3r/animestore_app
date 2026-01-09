import 'package:anime_app/src/core/infrastructure/animestore_dependecy_injector.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';

import '../../infrastructure/repository/animestore_remote_app_settings.repo.impl.dart';
import '../datasource/fb_remote_settings.datasource.impl.dart';

class AnimestoreSettingsDependencyInjectorImp
    extends AnimestoreDependecyInjector {
  final GetIt _getIt;

  AnimestoreSettingsDependencyInjectorImp(this._getIt);

  @override
  void inject() {
    if (!_getIt.isRegistered<FirebaseRemoteSettingsDatasourceImpl>()) {
      _getIt.registerFactory<FirebaseRemoteSettingsDatasourceImpl>(() =>
          FirebaseRemoteSettingsDatasourceImpl(
              service: FirebaseRemoteConfig.instance));
    }

    if (!_getIt.isRegistered<AnimestoreRemoteAppSettingsRepositoryImpl>()) {
      _getIt.registerFactory<AnimestoreRemoteAppSettingsRepositoryImpl>(() =>
          AnimestoreRemoteAppSettingsRepositoryImpl(
              _getIt<FirebaseRemoteSettingsDatasourceImpl>()));
    }
  }
}
