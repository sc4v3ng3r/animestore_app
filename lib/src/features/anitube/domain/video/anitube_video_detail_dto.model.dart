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
    final animeId = extractAttr('video-anime-detalhe', 'href');

    final previousHref = extractAttr('video-anterior-detalhe', 'href');
    final nextHref = extractAttr('video-seguinte-detalhe', 'href');

    final streamUrl = _normalizeStreamingUrl(streamingUrl);
    return AnitubeEpisodeVideoDetailsDto(
      title: title,
      streamingUrl: streamUrl,
      referer: map['referer']?.toString() ?? streamingUrl,
      animeId: animeId.extractIdFromUrl(),
      previousEpisodeId: previousHref.extractIdFromUrl(),
      nextEpisodeId: nextHref.extractIdFromUrl(),
    );
  }

  static String _normalizeStreamingUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return url;

    if (uri.host.contains('api.anivideo.net') &&
        uri.path.contains('videohls.php')) {
      final real = uri.queryParameters['d'];
      if (real != null && real.isNotEmpty) {
        return real;
      }
    }

    return url;
  }
}
