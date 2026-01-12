import '../http/animestore_http_request.model.dart';

abstract class AnimeStoreContentSettings {
  final Map<String, dynamic> declaration;
  final AnimeStoreHttpRequest requestSettings;

  const AnimeStoreContentSettings(
      {required this.declaration, required this.requestSettings});
}

class AnimeStoreContentSettingsImpl extends AnimeStoreContentSettings {
  const AnimeStoreContentSettingsImpl(
      {required super.declaration, required super.requestSettings});
}
