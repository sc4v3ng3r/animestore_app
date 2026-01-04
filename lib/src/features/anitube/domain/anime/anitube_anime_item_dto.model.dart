import '../../../../core/domain/models/Item.model.dart';

/// Item representation for an anime.
class AnitubeAnimeItemImpl extends Item {
  static const ID = "id";
  static const PAGE_URL = "pageUrl";
  static const IMAGE_URL = "imageUrl";
  static const TITLE = "title";
  static const CC = "closeCaption";

  AnitubeAnimeItemImpl(
      {required super.id,
      required super.pageUrl,
      required super.title,
      super.imageUrl = '',
      super.closeCaptionType = ''});

  factory AnitubeAnimeItemImpl.fromJson(Map<String, dynamic> json) =>
      AnitubeAnimeItemImpl(
        id: json[ID],
        pageUrl: json[PAGE_URL],
        title: json[TITLE],
        imageUrl: json[IMAGE_URL] ?? '',
        closeCaptionType: json[CC] ?? '',
      );
}
