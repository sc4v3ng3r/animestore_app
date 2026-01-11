import '../../domain/models/http/animestore_http_request.model.dart';
import '../../domain/models/http/animestore_http_response.model.dart';

abstract class AnimestoreHttpClient {
  Future<AnimestoreHttpResponse> request(AnimeStoreHttpRequest request);
}
