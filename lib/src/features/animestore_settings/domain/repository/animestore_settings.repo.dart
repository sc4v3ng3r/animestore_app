import '../model/animestore_app_settings.model.dart';

abstract class AnimeStoreSettingsRepository {
  Future<AnimestoreAppSettings> getAppSettings();
}
