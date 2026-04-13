import 'package:dio/dio.dart';
import 'package:eduon/core/constants/api_constants.dart';
import 'package:eduon/core/models/playlist_model.dart';
import 'package:eduon/core/models/video_model.dart';

class YoutubeApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  // جيب معلومات الـ Playlist
  Future<PlaylistModel> getPlaylistDetails(
      String playlistId, String category) async {
    try {
      final response = await _dio.get(
        '/playlists',
        queryParameters: {
          'part': 'snippet,contentDetails',
          'id': playlistId,
          'key': ApiConstants.apiKey,
        },
      );

      final items = response.data['items'] as List;
      if (items.isEmpty) {
        throw Exception('Playlist not found');
      }

      return PlaylistModel.fromJson(items[0], category);
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }

  // جيب فيديوهات الـ Playlist
  Future<List<VideoModel>> getPlaylistVideos(String playlistId) async {
    List<VideoModel> allVideos = [];
    String? nextPageToken;

    try {
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
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }

  // جيب الـ viewCount و duration
  Future<List<VideoModel>> getVideosDetails(List<VideoModel> videos) async {
    if (videos.isEmpty) return videos;

    try {
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
                int.tryParse(detail['statistics']?['viewCount'] ?? '0') ?? 0,
            duration: detail['contentDetails']?['duration'] ?? '',
          );
        }
        return video;
      }).toList();
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }
}
