import 'animestore_api_setting.model.dart';

abstract class AnimestoreFeatureSettings {
  final bool isEnable;
  final AnimeStoreApiSetting apiSettings;
  final Map<String, dynamic> parserDeclaration;

  const AnimestoreFeatureSettings(
      {required this.isEnable,
      required this.apiSettings,
      required this.parserDeclaration});
}

class AnimestoreFeatureSettingsImpl extends AnimestoreFeatureSettings {
  const AnimestoreFeatureSettingsImpl(
      {super.isEnable = false,
      required super.apiSettings,
      required super.parserDeclaration});

  factory AnimestoreFeatureSettingsImpl.fromMap(Map<String, dynamic> json) {
    return AnimestoreFeatureSettingsImpl(
      isEnable: json['isEnable'] ?? false,
      apiSettings: AnimeStoreApiSettingImpl.fromMap(
        Map<String, dynamic>.from(json['api-settings']),
      ),
      parserDeclaration:
          Map<String, dynamic>.from(json['parser-declaration'] ?? {}),
    );
  }
}
