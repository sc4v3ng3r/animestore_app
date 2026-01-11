import 'package:dio/dio.dart';
import '../../domain/models/failure/animestore_failure.model.dart';
import '../../domain/models/http/animestore_http_request.model.dart';
import '../../domain/models/http/animestore_http_response.model.dart';
import '../../infrastructure/http/animestore_http_client.dart';

class AnimestoreHttpClientImpl extends AnimestoreHttpClient {
  final Dio _dioClient;

  AnimestoreHttpClientImpl(this._dioClient);

  @override
  Future<AnimestoreHttpResponse> request(AnimeStoreHttpRequest request) {
    try {
      switch (request.method) {
        case HttpMethod.get:
          return _get(request);
      }
    } on DioException catch (error) {
      throw AnimestoreNetworFailure(
          description: error.response?.statusMessage ??
              'AnimestoreNetworFailure:: ${error.toString()}');
    }
  }

  Future<AnimestoreHttpResponse> _get(AnimeStoreHttpRequest settings) async {
    final results = await _dioClient.get(
        Uri.parse(settings.baseUrl + settings.path).toString(),
        queryParameters: settings.parameters,
        options: Options(
          headers: settings.headers,
        ));
    return AnimestoreHttpResponse(responseData: results.data);
  }
  // _post() {}
  // _put() {}
  // _delete() {}
}
