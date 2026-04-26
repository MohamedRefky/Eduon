import 'package:eduon/core/constants/api_constants.dart';
import 'package:eduon/features/courses/data/models/category_model.dart';
import 'package:eduon/features/courses/data/models/playlist_model.dart';
import 'package:eduon/features/courses/data/models/video_model.dart';
import 'package:eduon/features/courses/data/services/youtube_api_service.dart';

class CourseRepository {
  final YoutubeApiService _apiService = YoutubeApiService();

  // =========================
  // GET ALL CATEGORIES
  // =========================
  Future<List<CategoryModel>> getAllCategories() async {
    Set<String> allPlaylistIds = {};
    for (final entry in ApiConstants.categoryPlaylists.entries) {
      allPlaylistIds.addAll(entry.value);
    }

    List<PlaylistModel> allPlaylists = [];
    if (allPlaylistIds.isNotEmpty) {
      try {
        allPlaylists = await _apiService.getMultiplePlaylistsDetails(allPlaylistIds.toList());
      } catch (e) {
        // ignore error
      }
    }

    List<CategoryModel> categories = [];
    for (final entry in ApiConstants.categoryPlaylists.entries) {
      final categoryName = entry.key;
      final categoryPlaylistIds = entry.value;

      final categoryPlaylists = allPlaylists
          .where((p) => categoryPlaylistIds.contains(p.playlistId))
          .toList();

      if (categoryPlaylists.isNotEmpty) {
        categories.add(
          CategoryModel(
            name: categoryName,
            playlists: categoryPlaylists,
          ),
        );
      } else {
        categories.add(
          CategoryModel(
            name: categoryName,
            playlists: [],
          ),
        );
      }
    }

    return categories;
  }

  // =========================
  // GET PLAYLIST BY ID
  // =========================
  Future<PlaylistModel> getPlaylistById(String playlistId) async {
    String category = '';

    for (final entry in ApiConstants.categoryPlaylists.entries) {
      if (entry.value.contains(playlistId)) {
        category = entry.key;
        break;
      }
    }

    return await _apiService.getPlaylistDetails(playlistId, category);
  }

  // =========================
  // GET PLAYLIST WITH VIDEOS
  // (ENRICHED)
  // =========================
  Future<PlaylistModel> getPlaylistWithVideos(String playlistId) async {
    final playlist = await getPlaylistById(playlistId);
    final videos = await _apiService.getPlaylistVideos(playlistId);

    List<VideoModel> videosWithDetails = [];

    if (videos.isNotEmpty) {
      for (var i = 0; i < videos.length; i += 50) {
        final end = (i + 50 < videos.length) ? i + 50 : videos.length;
        final batch = videos.sublist(i, end);

        try {
          final details = await _apiService.getVideosDetails(batch);
          videosWithDetails.addAll(details);
        } catch (e) {
          videosWithDetails.addAll(batch);
        }
      }
    }

    return playlist.copyWith(videos: videosWithDetails);
  }

  // =========================
  // GET POPULAR COURSES
  // =========================
  Future<List<PlaylistModel>> getPopularCourses() async {
    Set<String> allPlaylistIds = {};
    for (final entry in ApiConstants.categoryPlaylists.entries) {
      allPlaylistIds.addAll(entry.value);
    }

    List<PlaylistModel> allPlaylists = [];
    if (allPlaylistIds.isNotEmpty) {
      try {
        allPlaylists = await _apiService.getMultiplePlaylistsDetails(allPlaylistIds.toList());
      } catch (e) {
        // ignore error
      }
    }
    allPlaylists.sort(
      (a, b) => b.videoCount.compareTo(a.videoCount),
    );

    return allPlaylists.take(50).toList();
  }
}