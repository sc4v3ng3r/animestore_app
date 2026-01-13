import '../../../../core/domain/models/anime_details.model.dart';
import '../../../../core/domain/models/content/animestore_content_settings.model.dart';
import '../../../../core/infrastructure/datasource/animestore_content_datasource.dart';
import '../../../../core/infrastructure/http/animestore_http_client.dart';
import '../../../../core/infrastructure/parser/animestore_content_parser.dart';
import '../../domain/anime/anitube_anime_details_dto.model.dart';

class AnitubeAnimeDetailsDatasourceImpl
    extends AnimestoreContentDatasource<Future<AnimeDetails>> {
  final AnimestoreHttpClient _httpClient;
  final AnimestoreContentParser _parser;

  AnitubeAnimeDetailsDatasourceImpl(this._httpClient, this._parser);

  @override
  Future<AnimeDetails> exec(AnimeStoreContentSettings settings) async {
    final response = await _httpClient.request(settings.request);

    final results = _parser.parse(
        contentToParse: response.responseData,
        declaration: settings.declaration);

    return _mapToDetailsContent(results);
  }

  AnimeDetails _mapToDetailsContent(Map<String, dynamic> map) {
    return AnitubeAnimeDetailsDto.fromMap(map);
  }
}
