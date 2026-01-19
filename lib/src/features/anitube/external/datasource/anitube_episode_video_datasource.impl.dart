import 'package:anime_app/src/core/domain/models/content/animestore_content_settings.model.dart';
import 'package:anime_app/src/core/infrastructure/http/animestore_http_client.dart';
import 'package:anime_app/src/core/infrastructure/parser/animestore_content_parser.dart';

import '../../../../core/domain/models/animestore_video_detail.model.dart';
import '../../../../core/infrastructure/datasource/animestore_content_datasource.dart';
import '../../domain/video/anitube_video_detail_dto.model.dart';

class AnitubeEpisodeVideoDatasourceImpl
    extends AnimestoreContentDatasource<Future<AnimestoreVideoDetails>> {
  final AnimestoreHttpClient _httpClient;
  final AnimestoreContentParser _parser;

  AnitubeEpisodeVideoDatasourceImpl(this._httpClient, this._parser);

  @override
  Future<AnimestoreVideoDetails> exec(
      AnimeStoreContentSettings settings) async {
    final response = await _httpClient.request(settings.request);

    final results = _parser.parse(
        contentToParse: response.responseData,
        declaration: settings.declaration);

    return AnitubeEpisodeVideoDetailsDto.fromMap(results);
  }
}
