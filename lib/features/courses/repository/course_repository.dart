import 'package:eduon/core/constants/api_constants.dart';
import 'package:eduon/core/models/category_model.dart';
import 'package:eduon/core/models/playlist_model.dart';
import 'package:eduon/core/models/video_model.dart';
import 'package:eduon/core/service/youtube_api_service.dart';

class CourseRepository {
  final YoutubeApiService _apiService = YoutubeApiService();

  // =========================
  // GET ALL CATEGORIES
  // =========================
  Future<List<CategoryModel>> getAllCategories() async {
    List<CategoryModel> categories = [];

    for (final entry in ApiConstants.categoryPlaylists.entries) {
      final categoryName = entry.key;
      final playlistIds = entry.value;

      List<PlaylistModel> playlists = [];

      for (final playlistId in playlistIds) {
        try {
          final playlist = await _apiService.getPlaylistDetails(
            playlistId,
            categoryName,
          );
          playlists.add(playlist);
        } catch (e) {
          continue;
        }
      }

      categories.add(
        CategoryModel(
          name: categoryName,
          playlists: playlists,
        ),
      );
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
    List<PlaylistModel> allPlaylists = [];

    for (final entry in ApiConstants.categoryPlaylists.entries) {
      final categoryName = entry.key;
      final playlistIds = entry.value;

      for (final playlistId in playlistIds) {
        try {
          final playlist = await _apiService.getPlaylistDetails(
            playlistId,
            categoryName,
          );
          allPlaylists.add(playlist);
        } catch (e) {
          continue;
        }
      }
    }

    // ترتيب حسب عدد الفيديوهات
    allPlaylists.sort(
      (a, b) => b.videoCount.compareTo(a.videoCount),
    );

    return allPlaylists.take(50).toList();
  }
}