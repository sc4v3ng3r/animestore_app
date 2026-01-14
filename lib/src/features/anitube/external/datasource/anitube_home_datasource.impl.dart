import '../../../../core/domain/models/content/animestore_content_settings.model.dart';
import '../../../../core/domain/models/animestore_content_item.model.dart';
import '../../../../core/infrastructure/datasource/animestore_content_datasource.dart';
import '../../../../core/infrastructure/http/animestore_http_client.dart';
import '../../../../core/infrastructure/parser/animestore_content_parser.dart';
import '../../../../core/domain/models/content/animestore_home_content.model.dart';
import '../../domain/anime/anitube_anime_item_dto.model.dart';
import '../../domain/episode/anitube_episode_item_dto.model.dart';

class AnitubeHomeDatasourceImpl
    extends AnimestoreContentDatasource<Future<AnimestoreHomeContent>> {
  final AnimestoreHttpClient _httpClient;
  final AnimestoreContentParser _parser;

  AnitubeHomeDatasourceImpl(this._httpClient, this._parser);

  @override
  Future<AnimestoreHomeContent> exec(AnimeStoreContentSettings settings) async {
    final response = await _httpClient.request(settings.request);

    final results = _parser.parse(
        contentToParse: response.responseData,
        declaration: settings.declaration);

    final moreViewed =
        List<Map<String, dynamic>>.from(results['lista-mais-vistos'])
            .map(_mapToAnimeItem)
            .toList();

    final moreRecents =
        List<Map<String, dynamic>>.from(results['lista-recentes'])
            .map(_mapToAnimeItem)
            .toList();

    final releases =
        List<Map<String, dynamic>>.from(results['lista-lancamentos'])
            .map(_mapToAnimeItem)
            .toList();

    final episodes = List<Map<String, dynamic>>.from(results['lista-episodios'])
        .map(_mapToEpisodeItem)
        .toList();

    return AnimestoreHomeContentImpl(
      dailyAnimeReleases: releases,
      mostViewedAnimes: moreViewed,
      recentEpisodes: episodes,
      topAnimes: moreRecents,
    );
  }

  AnimestoreContentItem _mapToAnimeItem(Map<String, dynamic> element) =>
      AnitubeAnimeItemDtoImpl.fromJson(element);

  AnimestoreContentItem _mapToEpisodeItem(Map<String, dynamic> element) =>
      AnitubeEpisodeItemDtoImpl.fromJson(element);
}
