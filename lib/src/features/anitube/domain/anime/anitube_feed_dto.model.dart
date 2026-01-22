import '../../../../core/domain/models/animestore_content_item.model.dart';
import '../../../../core/domain/models/content/animestore_content_feed_page.model.dart';
import 'anitube_anime_item_dto.model.dart';

class AnitubeFeedDto
    extends AnimestoreContentFeedPage<List<AnimestoreContentItem>> {
  const AnitubeFeedDto({
    required super.content,
    required super.currentPage,
    required super.maxPage,
  });

  factory AnitubeFeedDto.fromMap(Map<String, dynamic> map) {
    // -------- CONTENT (lista-animes) --------
    final List<dynamic> rawList =
        (map['lista-animes'] as List<dynamic>?) ?? const [];

    final content = rawList
        .whereType<Map<String, dynamic>>()
        .map(
          (e) => AnitubeAnimeItemDtoImpl.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
        .toList();

    // -------- PAGINAÇÃO --------
    int currentPage = -1;
    int maxPage = -1;

    final List<dynamic> pagination =
        (map['paginacao'] as List<dynamic>?) ?? const [];

    if (pagination.isNotEmpty) {
      final firstPageBlock = Map<String, dynamic>.from(pagination.first);

      final children =
          Map<String, dynamic>.from(firstPageBlock['children'] ?? {});

      // 1) currentPage -> pagina-atual
      final paginaAtual =
          Map<String, dynamic>.from(children['pagina-atual'] ?? {});

      final currentText = paginaAtual['attributes']?['text']?.toString();

      currentPage = int.tryParse(currentText ?? '') ?? -1;

      // 2) maxPage -> ultimo item de paginas-disponiveis
      final List<dynamic> pages =
          (children['paginas-disponiveis'] as List<dynamic>?) ?? const [];

      if (pages.isNotEmpty) {
        final last = Map<String, dynamic>.from(pages.last);

        final lastText = last['attributes']?['text']?.toString();

        maxPage = int.tryParse(lastText ?? '') ?? currentPage;

        // Se só houver 1 item, max = current
        if (pages.length == 1) {
          maxPage = currentPage;
        }
      } else {
        // Sem paginas-disponiveis, mas com pagina-atual
        maxPage = currentPage;
      }
    }

    return AnitubeFeedDto(
      content: content,
      currentPage: currentPage,
      maxPage: maxPage,
    );
  }
}
