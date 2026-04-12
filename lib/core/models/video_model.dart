
class VideoModel {
  final String videoId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String channelTitle;
  final int position;
  final int viewCount;
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
  });

  factory VideoModel.fromPlaylistItem(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    final thumbnails = snippet['thumbnails'];

    String thumbnail = '';
    if (thumbnails['maxres'] != null) {
      thumbnail = thumbnails['maxres']['url'];
    } else if (thumbnails['high'] != null) {
      thumbnail = thumbnails['high']['url'];
    } else if (thumbnails['medium'] != null) {
      thumbnail = thumbnails['medium']['url'];
    } else {
      thumbnail = thumbnails['default']['url'];
    }

    return VideoModel(
      videoId: snippet['resourceId']['videoId'],
      title: snippet['title'],
      description: snippet['description'] ?? '',
      thumbnailUrl: thumbnail,
      channelTitle: snippet['videoOwnerChannelTitle'] ?? '',
      position: snippet['position'] ?? 0,
    );
  }

  VideoModel copyWith({
    int? viewCount,
    String? duration,
  }) {
    return VideoModel(
      videoId: videoId,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      channelTitle: channelTitle,
      position: position,
      viewCount: viewCount ?? this.viewCount,
      duration: duration ?? this.duration,
    );
  }
}