import 'package:eduon/core/constants/api_constants.dart';
import 'package:eduon/core/models/category_model.dart';
import 'package:eduon/core/models/playlist_model.dart';
import 'package:eduon/core/models/video_model.dart';
import 'package:eduon/data/services/youtube_api_service.dart';

class CourseRepository {
  final YoutubeApiService _apiService = YoutubeApiService();

  // جيب كل الـ Categories مع الـ Playlists بتاعتهم
  Future<List<CategoryModel>> getAllCategories() async {
    List<CategoryModel> categories = [];

    for (final entry in ApiConstants.categoryPlaylists.entries) {
      final categoryName = entry.key;
      final playlistIds = entry.value;

      List<PlaylistModel> playlists = [];

      for (final playlistId in playlistIds) {
        final playlist = await _apiService.getPlaylistDetails(
          playlistId,
          categoryName,
        );
        playlists.add(playlist);
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

  // جيب الـ Playlist Details بالـ ID بس
  Future<PlaylistModel> getPlaylistById(String playlistId) async {
    // هنبحث في الـ categoryPlaylists عن الـ Category بتاعت الـ Playlist دي
    String category = '';

    for (final entry in ApiConstants.categoryPlaylists.entries) {
      if (entry.value.contains(playlistId)) {
        category = entry.key;
        break;
      }
    }

    return await _apiService.getPlaylistDetails(playlistId, category);
  }

  // جيب فيديوهات Playlist معينة بالـ ID بس
  Future<PlaylistModel> getPlaylistWithVideos(String playlistId) async {
    // جيب الـ Playlist Details
    final playlist = await getPlaylistById(playlistId);

    // جيب الفيديوهات
    final videos = await _apiService.getPlaylistVideos(playlistId);

    // جيب الـ viewCount و duration لكل فيديو
    final videosWithDetails = await _apiService.getVideosDetails(videos);

    return playlist.copyWith(videos: videosWithDetails);
  }

  // جيب الـ Popular Courses من كل الـ Categories
  Future<List<PlaylistModel>> getPopularCourses() async {
    List<PlaylistModel> allPlaylists = [];

    for (final entry in ApiConstants.categoryPlaylists.entries) {
      final categoryName = entry.key;
      final playlistIds = entry.value;

      for (final playlistId in playlistIds) {
        final playlist = await _apiService.getPlaylistDetails(
          playlistId,
          categoryName,
        );

        // جيب أول فيديو بس عشان ناخد الـ viewCount
        final videos = await _apiService.getPlaylistVideos(playlistId);

        if (videos.isNotEmpty) {
          final firstVideo = <VideoModel>[videos.first];
          final videosWithDetails =
              await _apiService.getVideosDetails(firstVideo);
          allPlaylists.add(playlist.copyWith(videos: videosWithDetails));
        } else {
          allPlaylists.add(playlist);
        }
      }
    }

    // رتب على حسب الـ viewCount من أعلى لأقل
    allPlaylists.sort((a, b) {
      final aViews = a.videos.isNotEmpty ? a.videos.first.viewCount : 0;
      final bViews = b.videos.isNotEmpty ? b.videos.first.viewCount : 0;
      return bViews.compareTo(aViews);
    });

    // رجع أول 10 بس
    return allPlaylists.take(10).toList();
  }
}
