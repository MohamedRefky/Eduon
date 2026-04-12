import 'package:dio/dio.dart';
import 'package:eduon/core/constants/api_constants.dart';
import 'package:eduon/core/models/playlist_model.dart';
import 'package:eduon/core/models/video_model.dart';

class YoutubeApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // جيب معلومات الـ Playlist
  Future<PlaylistModel> getPlaylistDetails(
    String playlistId,
    String category,
  ) async {
    final response = await _dio.get(
      '/playlists',
      queryParameters: {
        'part': 'snippet,contentDetails',
        'id': playlistId,
        'key': ApiConstants.apiKey,
      },
    );

    final item = response.data['items'][0];
    return PlaylistModel.fromJson(item, category);
  }

  // جيب فيديوهات الـ Playlist
  Future<List<VideoModel>> getPlaylistVideos(String playlistId) async {
    List<VideoModel> allVideos = [];
    String? nextPageToken;

    do {
      final response = await _dio.get(
        '/playlistItems',
        queryParameters: {
          'part': 'snippet',
          'playlistId': playlistId,
          'maxResults': 50,
          'key': ApiConstants.apiKey,
          'pageToken': ?nextPageToken,
        },
      );

      final items = response.data['items'] as List;
      allVideos.addAll(
        items.map((item) => VideoModel.fromPlaylistItem(item)).toList(),
      );

      nextPageToken = response.data['nextPageToken'];
    } while (nextPageToken != null);

    return allVideos;
  }

  // جيب الـ viewCount و duration لكل فيديو
  Future<List<VideoModel>> getVideosDetails(List<VideoModel> videos) async {
    final videoIds = videos.map((v) => v.videoId).join(',');

    final response = await _dio.get(
      '/videos',
      queryParameters: {
        'part': 'statistics,contentDetails',
        'id': videoIds,
        'key': ApiConstants.apiKey,
      },
    );

    final items = response.data['items'] as List;

    return videos.map((video) {
      final detail = items.firstWhere(
        (item) => item['id'] == video.videoId,
        orElse: () => null,
      );

      if (detail != null) {
        return video.copyWith(
          viewCount:
              int.tryParse(detail['statistics']['viewCount'] ?? '0') ?? 0,
          duration: detail['contentDetails']['duration'] ?? '',
        );
      }
      return video;
    }).toList();
  }
}
