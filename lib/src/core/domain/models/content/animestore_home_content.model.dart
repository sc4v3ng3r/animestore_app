import '../content_item.model.dart';

abstract class AnimestoreHomeContent {
  final List<ContentItem> topAnimes;
  final List<ContentItem> mostViewedAnimes;
  final List<ContentItem> dailyAnimeReleases;
  final List<ContentItem> recentEpisodes;
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
