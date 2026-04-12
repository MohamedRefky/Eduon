

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

    return PlaylistModel(
      playlistId: json['id'],
      title: snippet['title'],
      description: snippet['description'] ?? '',
      thumbnailUrl: thumbnail,
      channelTitle: snippet['channelTitle'] ?? '',
      videoCount: json['contentDetails']['itemCount'] ?? 0,
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
}