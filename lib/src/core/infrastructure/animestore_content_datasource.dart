enum HttpMethod { get, post, put, delete, patch }

class AnimeStoreRequestSettings {
  final String baseUrl;
  final String path;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> parameters;
  final HttpMethod method;
  final dynamic body;

  const AnimeStoreRequestSettings({
    required this.baseUrl,
    required this.method,
    this.path = '',
    this.headers = const {},
    this.parameters = const {},
    this.body = const {},
  });
}

abstract class AnimestoreContentDatasource<T> {
  T exec(AnimeStoreRequestSettings settings);
}
