import '../../../../core/domain/models/animestore_video_detail.model.dart';
import '../../../../core/extensions/string_format.extension.dart';

class AnitubeEpisodeVideoDetailsDto extends AnimestoreVideoDetails {
  AnitubeEpisodeVideoDetailsDto({
    required super.title,
    required super.streamingUrl,
    required super.referer,
    required super.animeId,
    super.previousEpisodeId = '',
    super.nextEpisodeId = '',
  }) : super(description: '');

  factory AnitubeEpisodeVideoDetailsDto.fromMap(
    Map<String, dynamic> map,
  ) {
    String extractText(String key) {
      final list = map[key] as List?;
      if (list == null || list.isEmpty) return '';
      return list.first['attributes']?['text']?.toString() ?? '';
    }

    String extractAttr(String key, String attr) {
      final list = map[key] as List?;
      if (list == null || list.isEmpty) return '';
      return list.first['attributes']?[attr]?.toString() ?? '';
    }

    final title = extractText('video-titulo');
    final streamingUrl = extractAttr('video-link', 'src');

    final previousHref = extractAttr('video-anterior-detalhe', 'href');
    final nextHref = extractAttr('video-seguinte-detalhe', 'href');

    return AnitubeEpisodeVideoDetailsDto(
      title: title,
      streamingUrl: streamingUrl,
      referer: map['referer']?.toString() ?? '',
      animeId: map['animeId']?.toString() ?? '',
      previousEpisodeId: previousHref.extractIdFromUrl(),
      nextEpisodeId: nextHref.extractIdFromUrl(),
    );
  }
}
