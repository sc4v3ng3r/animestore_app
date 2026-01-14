import '../../../../core/domain/models/animestore_content_item.model.dart';

class AnitubeEpisodeItemDtoImpl extends AnimestoreContentItem {
  const AnitubeEpisodeItemDtoImpl(
      {required super.id,
      required super.pageUrl,
      required super.title,
      super.imageUrl = '',
      super.closeCaptionType = ''});

  factory AnitubeEpisodeItemDtoImpl.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
    final children = json['children'] as Map<String, dynamic>? ?? {};

    // pageUrl
    final pageUrl = attributes['href'] as String? ?? '';

    // id → último segmento da URL
    final id = _extractIdFromUrl(pageUrl);

    // title
    final title = attributes['title'] as String? ?? '';

    // imageUrl → episodio-imagem.attributes.src
    final imageUrl =
        (children['episodio-imagem']?['attributes']?['src']) as String? ?? '';

    // closeCaptionType → episodio-legenda.attributes.text
    final closeCaptionType =
        (children['episodio-legenda']?['attributes']?['text']) as String? ?? '';

    return AnitubeEpisodeItemDtoImpl(
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
    if (uri == null || uri.pathSegments.isEmpty) return '';

    return uri.pathSegments.last;
  }
}
