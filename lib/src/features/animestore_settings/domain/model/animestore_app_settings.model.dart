import 'animestore_feature_settings.model.dart';

abstract class AnimestoreAppSettings {
  final Map<String, AnimestoreFeatureSettings> features;

  const AnimestoreAppSettings({required this.features});
}

class AnimestoreAppSettingsImpl extends AnimestoreAppSettings {
  const AnimestoreAppSettingsImpl({required super.features});

  factory AnimestoreAppSettingsImpl.fromMap(Map<String, dynamic> json) {
    final root = Map<String, dynamic>.from(json['features']);

    final featuresMap = <String, AnimestoreFeatureSettings>{};

    for (final entry in root.entries) {
      featuresMap[entry.key] = AnimestoreFeatureSettingsImpl.fromMap(
        Map<String, dynamic>.from(entry.value),
      );
    }
    return AnimestoreAppSettingsImpl(features: featuresMap);
  }
}
