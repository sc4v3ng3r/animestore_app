import '../http/animestore_http_request.model.dart';

abstract class AnimeStoreContentSettings {
  final Map<String, dynamic> declaration;
  final AnimeStoreHttpRequest request;

  const AnimeStoreContentSettings(
      {required this.declaration, required this.request});
}

class AnimeStoreContentSettingsImpl extends AnimeStoreContentSettings {
  const AnimeStoreContentSettingsImpl(
      {required super.declaration, required super.request});
}
