import '../../../../core/domain/models/animestore_video_detail.model.dart';

class AnitubeVideoDetailDtoImpl extends AnimestoreVideoDetails {
  AnitubeVideoDetailDtoImpl({
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

  AnitubeVideoDetailDtoImpl.fromJson(Map<String, dynamic> json)
      : super(
          title: json[AnimestoreVideoDetails.TITLE] ?? '',
          streamingUrl: json[AnimestoreVideoDetails.STREAM_URL] ?? '',
          previousEpisodeId: json[AnimestoreVideoDetails.PREVIOUS] ?? '',
          nextEpisodeId: json[AnimestoreVideoDetails.NEXT] ?? '',
          description: json[AnimestoreVideoDetails.DESCRIPTION] ?? '',
          referer: json[AnimestoreVideoDetails.REFERER] ?? '',
          animeId: json[AnimestoreVideoDetails.ANIME_ID] ?? '',
        );
}
