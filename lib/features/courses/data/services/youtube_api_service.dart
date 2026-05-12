import 'package:dio/dio.dart';
import 'dart:ui' as ui;
import 'package:eduon/core/constants/api_constants.dart';
import 'package:eduon/features/courses/data/models/playlist_model.dart';
import 'package:eduon/features/courses/data/models/video_model.dart';

class YoutubeApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  String get _currentLocale => ui.PlatformDispatcher.instance.locale.languageCode;

  // =========================
  // GET PLAYLIST DETAILS
  // =========================
  Future<PlaylistModel> getPlaylistDetails(
    String playlistId,
    String category, {
    String? hl,
  }) async {
    try {
      final response = await _dio.get(
        '/playlists',
        queryParameters: {
          'part': 'snippet,contentDetails',
          'id': playlistId,
          'hl': hl ?? _currentLocale,
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

  // =========================
  // GET MULTIPLE PLAYLISTS DETAILS
  // =========================
  Future<List<PlaylistModel>> getMultiplePlaylistsDetails(
    List<String> playlistIds, {
    String? hl,
  }) async {
    if (playlistIds.isEmpty) return [];

    List<PlaylistModel> allPlaylists = [];

    for (var i = 0; i < playlistIds.length; i += 50) {
      final end = (i + 50 < playlistIds.length) ? i + 50 : playlistIds.length;
      final batch = playlistIds.sublist(i, end);

      try {
        final response = await _dio.get(
          '/playlists',
          queryParameters: {
            'part': 'snippet,contentDetails',
            'id': batch.join(','),
            'hl': hl ?? _currentLocale,
            'key': ApiConstants.apiKey,
          },
        );

        final items = response.data['items'] as List;

        allPlaylists.addAll(items.map((item) {
          String category = '';
          for (final entry in ApiConstants.categoryPlaylists.entries) {
            if (entry.value.contains(item['id'])) {
              category = entry.key;
              break;
            }
          }
          return PlaylistModel.fromJson(item, category);
        }).toList());
      } on DioException catch (e) {
        throw Exception('API Error: ${e.message}');
      }
    }

    return allPlaylists;
  }

  // =========================
  // GET PLAYLIST VIDEOS
  // =========================
  Future<List<VideoModel>> getPlaylistVideos(String playlistId,
      {String? hl}) async {
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
            'hl': hl ?? _currentLocale,
            'key': ApiConstants.apiKey,
            'pageToken': nextPageToken,
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

  // =========================
  // GET VIDEOS STATS (views, likes, duration)
  // =========================
  Future<List<VideoModel>> getVideosDetails(List<VideoModel> videos,
      {String? hl}) async {
    if (videos.isEmpty) return videos;

    try {
      final videoIds = videos.map((v) => v.videoId).join(',');

      final response = await _dio.get(
        '/videos',
        queryParameters: {
          'part': 'snippet,statistics,contentDetails',
          'id': videoIds,
          'hl': hl ?? _currentLocale,
          'key': ApiConstants.apiKey,
        },
      );

      final items = response.data['items'] ?? [];

      if (items.isEmpty) return videos;

      final Map<String, dynamic> detailsMap = {
        for (var item in items) item['id']: item,
      };

      return videos.map((video) {
        final detail = detailsMap[video.videoId];

        if (detail == null) return video;

        final snippet = (detail['snippet'] ?? {}) as Map;
        final stats = (detail['statistics'] ?? {}) as Map;
        final content = (detail['contentDetails'] ?? {}) as Map;

        return video.copyWith(
          title: snippet['title'] ?? video.title,
          viewCount: int.tryParse(stats['viewCount']?.toString() ?? '0') ?? 0,
          likeCount: int.tryParse(stats['likeCount']?.toString() ?? '0') ?? 0,
          duration: _formatDuration(content['duration'] ?? ''),
        );
      }).toList();
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }
}
String _formatDuration(String iso) {
  final regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');

  final match = regex.firstMatch(iso);

  if (match == null) return '0:00';

  final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
  final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;
  final seconds = int.tryParse(match.group(3) ?? '0') ?? 0;

  final totalMinutes = hours * 60 + minutes;
  final sec = seconds.toString().padLeft(2, '0');

  return '$totalMinutes:$sec';
}