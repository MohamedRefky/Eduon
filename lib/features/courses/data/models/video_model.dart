class VideoModel {
  final String videoId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String channelTitle;
  final int position;
  final int viewCount;
  final int likeCount;
  final String duration;

  VideoModel({
    required this.videoId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.position,
    this.viewCount = 0,
    this.duration = '',
    this.likeCount = 0,
  });

  factory VideoModel.fromPlaylistItem(Map<String, dynamic> json) {
    final snippet = json['snippet'] as Map<String, dynamic>? ?? {};
    final thumbnails = snippet['thumbnails'] as Map<String, dynamic>? ?? {};
    final resourceId = snippet['resourceId'] as Map<String, dynamic>? ?? {};

    final thumbnail = _extractThumbnailUrl(thumbnails);

    return VideoModel(
      videoId: (resourceId['videoId'] ?? '').toString(),
      title: (snippet['title'] ?? '').toString(),
      description: (snippet['description'] ?? '').toString(),
      thumbnailUrl: thumbnail,
      channelTitle:
          (snippet['videoOwnerChannelTitle'] ?? snippet['channelTitle'] ?? '')
              .toString(),
      position: snippet['position'] ?? 0,
    );
  }

  VideoModel copyWith({int? viewCount, String? duration, int? likeCount}) {
    return VideoModel(
      videoId: videoId,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      channelTitle: channelTitle,
      position: position,
      viewCount: viewCount ?? this.viewCount,
      duration: duration ?? this.duration,
      likeCount: likeCount ?? this.likeCount,
    );
  }

  static String _extractThumbnailUrl(Map<String, dynamic>? thumbnails) {
    if (thumbnails == null) return '';

    return (thumbnails['maxres']?['url'] ??
            thumbnails['high']?['url'] ??
            thumbnails['medium']?['url'] ??
            thumbnails['default']?['url'] ??
            '')
        .toString();
  }
}
