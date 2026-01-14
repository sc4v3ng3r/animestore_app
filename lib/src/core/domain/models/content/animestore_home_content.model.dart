import '../animestore_content_item.model.dart';

abstract class AnimestoreHomeContent {
  final List<AnimestoreContentItem> topAnimes;
  final List<AnimestoreContentItem> mostViewedAnimes;
  final List<AnimestoreContentItem> dailyAnimeReleases;
  final List<AnimestoreContentItem> recentEpisodes;
  final List<String> genres;

  const AnimestoreHomeContent(
      {required this.topAnimes,
      required this.mostViewedAnimes,
      required this.dailyAnimeReleases,
      required this.recentEpisodes,
      required this.genres});
}

class AnimestoreHomeContentImpl extends AnimestoreHomeContent {
  const AnimestoreHomeContentImpl(
      {required super.topAnimes,
      required super.mostViewedAnimes,
      required super.dailyAnimeReleases,
      required super.recentEpisodes,
      super.genres = const []});
}
