import '../../../../core/domain/models/episode_detail.model.dart';

class AnitubeEpisodeVideoDetailImpl extends EpisodeDetails {
  AnitubeEpisodeVideoDetailImpl({
    required String title,
    required String referer,
    required String animeId,
    required String streamingUrl,
    String previousEpisodeId = '',
    String nextEpisodeId = '',
    String description = '',
  }) : super(
          title: title,
          referer: referer,
          animeId: animeId,
          streamingUrl: streamingUrl,
          previousEpisodeId: previousEpisodeId,
          nextEpisodeId: nextEpisodeId,
          description: description,
        );

  AnitubeEpisodeVideoDetailImpl.fromJson(Map<String, dynamic> json)
      : super(
          title: json[EpisodeDetails.TITLE] ?? '',
          streamingUrl: json[EpisodeDetails.STREAM_URL] ?? '',
          previousEpisodeId: json[EpisodeDetails.PREVIOUS] ?? '',
          nextEpisodeId: json[EpisodeDetails.NEXT] ?? '',
          description: json[EpisodeDetails.DESCRIPTION] ?? '',
          referer: json[EpisodeDetails.REFERER] ?? '',
          animeId: json[EpisodeDetails.ANIME_ID] ?? '',
        );
}
