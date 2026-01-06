import 'dart:io';

import 'package:anime_app/src/core/infrastructure/animestore_content_datasource.dart';
import 'package:anime_app/src/features/anitube/external/home_declaration_mock.dart';
import 'package:dompen/dompen.dart';

import '../../../core/domain/models/content_item.model.dart';
import '../../home/domain/animestore_home_content.model.dart';
import '../domain/anime/anitube_anime_item_dto.model.dart';
import 'dart:convert' as json;

import '../domain/episode/anitube_episode_item_dto.model.dart';

class AnitubeHomeDatasourceImpl
    extends AnimestoreContentDatasource<Future<AnimestoreHomeContent>> {
  @override
  Future<AnimestoreHomeContent> exec(AnimeStoreRequestSettings settings) async {
    final DompenHtmlEngineImpl engine = DompenHtmlEngineImpl();
    final DompenSettings dompenSettings = DompenSettings(
      parseContent: await File(
              '/Users/boaventura/Documents/2026/software/animestore_app/lib/src/features/anitube/page-samples/home.html')
          .readAsString(),
      declaration: json.jsonEncode(homeDeclarationMock),
    );

    final results = engine.parse(settings: dompenSettings);
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

    return Future.value(AnimestoreHomeContentImpl(
      dailyAnimeReleases: releases,
      mostViewedAnimes: moreViewed,
      recentEpisodes: episodes,
      topAnimes: moreRecents,
    ));
  }

  ContentItem _mapToAnimeItem(Map<String, dynamic> element) =>
      AnitubeAnimeItemDtoImpl.fromJson(element);

  ContentItem _mapToEpisodeItem(Map<String, dynamic> element) =>
      AnitubeEpisodeItemDtoImpl.fromJson(element);
}
