import 'package:eduon/core/constants/api_constants.dart';
import 'package:eduon/core/models/category_model.dart';
import 'package:eduon/core/models/playlist_model.dart';
import 'package:eduon/core/models/video_model.dart';
import 'package:eduon/data/services/youtube_api_service.dart';

class CourseRepository {
  final YoutubeApiService _apiService = YoutubeApiService();

  // جيب الـ Categories مع الـ Playlists بتاعتهم
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
          // لو Playlist فيها مشكلة نتخطاها
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

  // جيب الـ Playlist Details بالـ ID
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

  // جيب فيديوهات Playlist معينة بالـ ID
  Future<PlaylistModel> getPlaylistWithVideos(String playlistId) async {
    final playlist = await getPlaylistById(playlistId);
    final videos = await _apiService.getPlaylistVideos(playlistId);

    // جيب الـ viewCount لأول 50 فيديو بس
    List<VideoModel> videosWithDetails = [];
    if (videos.isNotEmpty) {
      // قسم الفيديوهات لمجموعات 50 عشان الـ API limit
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

  // جيب الـ Popular Courses - بسيط من غير API Calls كتير
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

    // رتب على حسب عدد الفيديوهات (بدل viewCount عشان نوفر API calls)
    allPlaylists.sort((a, b) => b.videoCount.compareTo(a.videoCount));

    return allPlaylists.take(5).toList();
  }
}

