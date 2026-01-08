import 'package:flutter/foundation.dart';

import '../../infrastructure/datasource/remote_settings.datasource.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'dart:convert' as json;

class FirebaseRemoteSettingsDatasourceImpl
    extends AnimeStoreRemoteSettingsDatasource {
  static const _rootKey = 'animestore_app_settings';
  final _defaultSettings = RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 8),
    minimumFetchInterval:
        kDebugMode ? const Duration(seconds: 1) : const Duration(seconds: 120),
  );

  final FirebaseRemoteConfig service;
  FirebaseRemoteSettingsDatasourceImpl({required this.service});

  @override
  Future<Map<String, dynamic>> getRemoteSettings() async {
    service.setConfigSettings(_defaultSettings);
    // service.setDefaults()

    return service.fetchAndActivate().then((isPositive) {
      if (isPositive) {
        final results = Map<String, dynamic>.from(
            json.jsonDecode(service.getString(_rootKey)));
        return results;
      }
      return <String, dynamic>{};
    }).catchError((failure) => <String, dynamic>{});
  }
}
