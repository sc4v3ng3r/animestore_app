import '../../../../core/domain/models/content_item.model.dart';

/// Item representation for an anime.
class AnitubeAnimeItemDtoImpl extends ContentItem {
  const AnitubeAnimeItemDtoImpl(
      {required super.id,
      required super.pageUrl,
      required super.title,
      super.imageUrl = '',
      super.closeCaptionType = ''});

  factory AnitubeAnimeItemDtoImpl.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
    final children = json['children'] as Map<String, dynamic>? ?? {};

    // pageUrl
    final pageUrl = attributes['href'] as String? ?? '';

    // id → último segmento do path do href
    final id = _extractIdFromUrl(pageUrl);

    // title
    final title = attributes['title'] as String? ?? '';

    // imageUrl → anime-imagem.attributes.src
    final imageUrl =
        (children['anime-imagem']?['attributes']?['src']) as String? ?? '';

    // closeCaptionType → anime-legenda.attributes.text
    final closeCaptionType =
        (children['anime-legenda']?['attributes']?['text']) as String? ?? '';

    return AnitubeAnimeItemDtoImpl(
      id: id,
      pageUrl: pageUrl,
      title: title,
      imageUrl: imageUrl,
      closeCaptionType: closeCaptionType,
    );
  }

  static String _extractIdFromUrl(String url) {
    if (url.isEmpty) return '';

    final uri = Uri.tryParse(url);
    if (uri == null) return '';

    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (segments.isEmpty) return '';

    return segments.last;
  }
}
