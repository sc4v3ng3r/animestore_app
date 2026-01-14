import '../../../../features/animestore_settings/domain/model/animestore_api_setting.model.dart';
import '../utils/placeholder_resolver.dart';

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

class AnimeStoreRequestParametrizedBuilder {
  static AnimeStoreHttpRequest build({
    required AnimeStoreApiSetting setting,
    List<String> pathParams = const [],
    List<String> bodyParams = const [],
    List<String> queryParams = const [],
    List<String> headersParams = const [],
  }) {
    return AnimeStoreHttpRequestImpl(
      baseUrl: setting.baseUrl,
      method: setting.method,
      path: PlaceholderResolver.resolve(setting.path, pathParams),
      headers: Map<String, dynamic>.from(
        PlaceholderResolver.resolve(setting.headers, headersParams),
      ),
      parameters: Map<String, dynamic>.from(
        PlaceholderResolver.resolve(setting.queryParams, queryParams),
      ),
      body: PlaceholderResolver.resolve(setting.body, bodyParams),
    );
  }
}
