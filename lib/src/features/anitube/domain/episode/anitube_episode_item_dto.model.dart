import '../../../../core/domain/models/Item.model.dart';

class AnitubeEpisodeItemImpl extends Item {
  static const ID = "id";
  static const PAGE_URL = "pageUrl";
  static const IMAGE_URL = "imageUrl";
  static const TITLE = "title";
  static const CC = "closeCaption";

  AnitubeEpisodeItemImpl(
      {required super.id,
      required super.pageUrl,
      required super.title,
      super.imageUrl = '',
      super.closeCaptionType = ''});

  factory AnitubeEpisodeItemImpl.fromJson(Map<String, dynamic> json) =>
      AnitubeEpisodeItemImpl(
        id: json[ID],
        pageUrl: json[PAGE_URL],
        title: json[TITLE],
        imageUrl: json[IMAGE_URL] ?? '',
        closeCaptionType: json[CC] ?? '',
      );
}
