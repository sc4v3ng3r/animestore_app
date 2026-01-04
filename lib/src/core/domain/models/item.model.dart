/// This is the base class for AnimeItem and EpisodeItem implementation.
/// actually both classes are equals to Item class only the name is different
/// to be more legible.
abstract class Item {
  /// The item id
  final String id;

  /// item page url
  final String pageUrl;

  /// Item cover image url
  final String imageUrl;

  /// Item title
  final String title;

  /// Item closed caption type.
  final String closeCaptionType;

  Item(
      {required this.id,
      required this.pageUrl,
      required this.imageUrl,
      required this.title,
      required this.closeCaptionType});
}
