import '../../../../core/domain/models/animestore_content_item.model.dart';
import '../../../../core/domain/models/content/animestore_content_feed_page.model.dart';
import '../../../../core/domain/models/content/animestore_content_settings.model.dart';
import '../../../../core/infrastructure/datasource/animestore_content_datasource.dart';
import '../../../../core/infrastructure/http/animestore_http_client.dart';
import '../../../../core/infrastructure/parser/animestore_content_parser.dart';
import '../../domain/anime/anitube_feed_dto.model.dart';

class AnitubeAnimeFeedDatasourceImpl extends AnimestoreContentDatasource<
    Future<AnimestoreContentFeedPage<List<AnimestoreContentItem>>>> {
  final AnimestoreHttpClient _httpClient;
  final AnimestoreContentParser _parser;

  AnitubeAnimeFeedDatasourceImpl(this._httpClient, this._parser);

  @override
  Future<AnimestoreContentFeedPage<List<AnimestoreContentItem>>> exec(
      AnimeStoreContentSettings settings) async {
    final results = await _httpClient.request(settings.request);

    final data = _parser.parse(
        contentToParse: results.responseData,
        declaration: settings.declaration);

    return AnitubeFeedDto.fromMap(data);
  }
}
