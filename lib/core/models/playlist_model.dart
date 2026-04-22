import 'video_model.dart';

class PlaylistModel {
  final String playlistId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String channelTitle;
  final int videoCount;
  final String category;
  final List<VideoModel> videos;

  PlaylistModel({
    required this.playlistId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.videoCount,
    required this.category,
    this.videos = const [],
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json, String category) {
    final snippet = json['snippet'] as Map<String, dynamic>? ?? {};
    final thumbnails = snippet['thumbnails'] as Map<String, dynamic>? ?? {};

    final thumbnail = _extractThumbnailUrl(thumbnails);

    return PlaylistModel(
      playlistId: json['id'] is String
          ? json['id'] as String
          : (json['id']?['playlistId'] ?? '').toString(),
      title: (snippet['title'] ?? 'No Title').toString(),
      description: (snippet['description'] ?? '').toString(),
      thumbnailUrl: thumbnail,
      channelTitle: (snippet['channelTitle'] ?? '').toString(),
      videoCount: json['contentDetails']?['itemCount'] ?? 0,
      category: category,
    );
  }

  PlaylistModel copyWith({List<VideoModel>? videos}) {
    return PlaylistModel(
      playlistId: playlistId,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      channelTitle: channelTitle,
      videoCount: videoCount,
      category: category,
      videos: videos ?? this.videos,
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