class EpisodeWatched {
  String id;
  String? title;
  int? viewedAt;

  EpisodeWatched({
    required this.id,
    this.title,
    this.viewedAt,
  });

  EpisodeWatched.fromJson(Map<String, dynamic> json)
      : id = json['episodeId'],
        title = json['episodeTitle'] ?? '',
        viewedAt = json['viewedAt'] ?? 0;

  Map<String, dynamic> toJson() => {
        'episodeId': this.id,
        'episodeTitle': this.title,
        'viewedAt': this.viewedAt,
      };
}
