import '../../../../core/domain/models/animestore_anime_details.model.dart';
import '../../../../core/domain/models/content/animestore_content_settings.model.dart';
import '../../../../core/infrastructure/datasource/animestore_content_datasource.dart';
import '../../../../core/infrastructure/http/animestore_http_client.dart';
import '../../../../core/infrastructure/parser/animestore_content_parser.dart';
import '../../domain/anime/anitube_anime_details_dto.model.dart';

class AnitubeAnimeDetailsDatasourceImpl
    extends AnimestoreContentDatasource<Future<AnimestoreAnimeDetails>> {
  final AnimestoreHttpClient _httpClient;
  final AnimestoreContentParser _parser;

  AnitubeAnimeDetailsDatasourceImpl(this._httpClient, this._parser);

  @override
  Future<AnimestoreAnimeDetails> exec(
      AnimeStoreContentSettings settings) async {
    final response = await _httpClient.request(settings.request);

    final results = _parser.parse(
        contentToParse: response.responseData,
        declaration: settings.declaration);

    return _mapToDetailsContent(results);
  }

  AnimestoreAnimeDetails _mapToDetailsContent(Map<String, dynamic> map) {
    return AnitubeAnimeDetailsDto.fromMap(map);
  }
}
