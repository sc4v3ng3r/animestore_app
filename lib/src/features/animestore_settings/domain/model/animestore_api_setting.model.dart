import 'package:anime_app/src/core/domain/models/http/animestore_http_request.model.dart';
import 'package:anime_app/src/core/domain/models/utils/mapable.dart';

abstract class AnimeStoreApiSetting with Mapable {
  final String baseUrl;
  final String path;
  final HttpMethod method;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> queryParams;
  final Map<String, dynamic> body;

  const AnimeStoreApiSetting({
    required this.baseUrl,
    required this.path,
    required this.method,
    required this.headers,
    required this.queryParams,
    required this.body,
  });
}

class AnimeStoreApiSettingImpl extends AnimeStoreApiSetting {
  AnimeStoreApiSettingImpl(
      {required super.baseUrl,
      required super.method,
      super.path = '',
      super.headers = const {},
      super.queryParams = const {},
      super.body = const {}});

  factory AnimeStoreApiSettingImpl.fromMap(Map<String, dynamic> map) {
    return AnimeStoreApiSettingImpl(
      baseUrl: map['baseUrl'] as String? ?? '',
      path: map['path'] as String? ?? '',
      method: ApiMethodType.fromString(
        (map['method'] as String? ?? 'get'),
      ),
      body: Map<String, dynamic>.from(
        map['body'] ?? const {},
      ),
      headers: Map<String, dynamic>.from(map['headers'] ?? const {}),
      queryParams: Map<String, dynamic>.from(map['queryParams'] ?? const {}),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'baseUrl': baseUrl,
      'path': path,
      'method': method.name,
      'body': body,
      'headers': headers,
      'queryParams': queryParams,
    };
  }
}

extension ApiMethodType on HttpMethod {
  String get name => toString().split('.').last;

  static HttpMethod fromString(String value) {
    return HttpMethod.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => HttpMethod.get,
    );
  }
}
