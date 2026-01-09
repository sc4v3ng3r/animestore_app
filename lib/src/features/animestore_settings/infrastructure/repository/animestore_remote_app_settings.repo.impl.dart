import '../../domain/model/animestore_app_settings.model.dart';
import '../../domain/repository/animestore_settings.repo.dart';
import '../datasource/remote_settings.datasource.dart';

class AnimestoreRemoteAppSettingsRepositoryImpl
    extends AnimeStoreSettingsRepository {
  final AnimeStoreRemoteSettingsDatasource _datasource;

  AnimestoreRemoteAppSettingsRepositoryImpl(this._datasource);

  @override
  Future<AnimestoreAppSettings> getAppSettings() async {
    final appSettings = await _datasource.getRemoteSettings();
    if (appSettings.isNotEmpty) {
      return AnimestoreAppSettingsImpl.fromMap(appSettings);
    }
    // TODO: adicionar default
    return AnimestoreAppSettingsImpl(features: {});
  }
}
