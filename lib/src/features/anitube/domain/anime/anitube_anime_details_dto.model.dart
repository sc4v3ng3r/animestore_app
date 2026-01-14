import '../../../../core/domain/models/animestore_anime_details.model.dart';
import '../../../../core/domain/models/animestore_content_item.model.dart';
import '../episode/anitube_episode_item_dto.model.dart';

class AnitubeAnimeDetailsDto extends AnimestoreAnimeDetails {
  AnitubeAnimeDetailsDto({
    required super.title,
    required super.imageUrl,
    required super.resume,
    required super.episodes,
  });

  factory AnitubeAnimeDetailsDto.fromMap(Map<String, dynamic> map) {
    return AnitubeAnimeDetailsDto(
      title: _readText(map, 'anime-title'),
      imageUrl: _readAttr(map, 'anime-capa', 'src'),
      resume: _readText(map, 'anime-sinopse'),
      episodes: _readEpisodes(map),
    );
  }

  static String _readText(Map<String, dynamic> map, String key) {
    final list = map[key] as List?;
    if (list == null || list.isEmpty) return '';

    final attrs = list.first['attributes'] as Map?;
    return attrs?['text']?.toString() ?? '';
  }

  static String _readAttr(Map<String, dynamic> map, String key, String attr) {
    final list = map[key] as List?;
    if (list == null || list.isEmpty) return '';

    final attrs = list.first['attributes'] as Map?;
    return attrs?[attr]?.toString() ?? '';
  }

  static List<AnimestoreContentItem> _readEpisodes(Map<String, dynamic> map) {
    final list = map['anime-episodes'] as List?;
    if (list == null) return [];

    return list.map<AnimestoreContentItem>((node) {
      return AnitubeEpisodeItemDtoImpl.fromJson(node);
    }).toList();
  }
}
