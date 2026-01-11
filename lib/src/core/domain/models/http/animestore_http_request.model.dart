enum HttpMethod {
  get,
  /*post,
  put,
  delete, patch*/
}

abstract class AnimeStoreHttpRequest {
  final String baseUrl;
  final String path;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> parameters;
  final HttpMethod method;
  final dynamic body;

  const AnimeStoreHttpRequest({
    required this.baseUrl,
    required this.method,
    required this.path,
    required this.headers,
    required this.parameters,
    required this.body,
  });
}

class AnimeStoreHttpRequestImpl extends AnimeStoreHttpRequest {
  const AnimeStoreHttpRequestImpl(
      {required super.baseUrl,
      required super.method,
      super.path = '',
      super.headers = const {},
      super.parameters = const {},
      super.body = const {}});
}
