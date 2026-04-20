import 'dart:convert';

import 'prefrances_maneger.dart';

class VideoProgressService {
  final PreferencesManager _prefs = PreferencesManager();

  static const String _watchedVideosKey = 'watched_videos';
  static const String _videoProgressKey = 'video_progress';
  static const String _courseInfoKey = 'course';

  // ✅ حفظ الفيديو كمكتمل
  Future<void> markAsWatched(String playlistId, String videoId) async {
    final watchedList = await getWatchedVideos(playlistId);

    if (!watchedList.contains(videoId)) {
      watchedList.add(videoId);
    }

    final key = '${_watchedVideosKey}_$playlistId';
    await _prefs.setString(key, jsonEncode(watchedList));
  }

  // ✅ جلب الفيديوهات المشاهدة في كورس معين
  Future<List<String>> getWatchedVideos(String playlistId) async {
    final key = '${_watchedVideosKey}_$playlistId';
    final data = _prefs.getString(key);

    if (data == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(data);
      return decoded.cast<String>();
    } catch (e) {
      return [];
    }
  }

  // ✅ حساب نسبة التقدم
  Future<double> getCourseProgress(String playlistId, int totalVideos) async {
    final watchedVideos = await getWatchedVideos(playlistId);
    if (totalVideos == 0) return 0.0;
    return watchedVideos.length / totalVideos;
  }

  // ✅ حفظ موضع الفيديو (للـ Resume)
  Future<void> saveVideoPosition(
    String videoId,
    int position,
    int duration,
  ) async {
    final progressData = {
      'position': position,
      'duration': duration,
      'timestamp': DateTime.now().toIso8601String(),
    };
    await _prefs.setString(
      '${_videoProgressKey}_$videoId',
      jsonEncode(progressData),
    );
  }

  // ✅ جلب آخر موضع للفيديو
  Future<int?> getVideoPosition(String videoId) async {
    final data = _prefs.getString('${_videoProgressKey}_$videoId');
    if (data == null) return null;

    try {
      final progressData = jsonDecode(data);
      return progressData['position'] as int?;
    } catch (e) {
      return null;
    }
  }

  // ✅ التحقق إذا كان الفيديو مكتمل
  Future<bool> isVideoWatched(String playlistId, String videoId) async {
    final watchedList = await getWatchedVideos(playlistId);
    return watchedList.contains(videoId);
  }

  // ✅ حفظ معلومات الكورس
  Future<void> saveCourseInfo(
    String playlistId,
    String title,
    int totalVideos,
    String? thumbnailUrl,
  ) async {
    final courseData = {
      'playlistId': playlistId,
      'title': title,
      'totalVideos': totalVideos,
      'thumbnailUrl': thumbnailUrl,
      'lastUpdated': DateTime.now().toIso8601String(),
    };
    await _prefs.setString(
      '${_courseInfoKey}_$playlistId',
      jsonEncode(courseData),
    );
  }

  // ✅ جلب معلومات كورس معين
  Future<Map<String, dynamic>?> getCourseInfo(String playlistId) async {
    final data = _prefs.getString('${_courseInfoKey}_$playlistId');
    if (data == null) return null;

    try {
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // ✅ جلب جميع الكورسات النشطة
  Future<List<Map<String, dynamic>>> getActiveCourses() async {
    List<Map<String, dynamic>> courses = [];

    final activePlaylistsData = _prefs.getString('active_playlists');
    if (activePlaylistsData == null) return [];

    try {
      final List<dynamic> playlistIds = jsonDecode(activePlaylistsData);

      for (var playlistId in playlistIds) {
        final courseInfo = await getCourseInfo(playlistId);
        if (courseInfo != null) {
          final watchedVideos = await getWatchedVideos(playlistId);
          final totalVideos = courseInfo['totalVideos'] ?? 0;

          courses.add({
            'playlistId': playlistId,
            'title': courseInfo['title'] ?? '',
            'thumbnailUrl': courseInfo['thumbnailUrl'],
            'totalVideos': totalVideos,
            'watchedVideos': watchedVideos.length,
            'progress': totalVideos > 0
                ? watchedVideos.length / totalVideos
                : 0.0,
            'lastUpdated': courseInfo['lastUpdated'],
          });
        }
      }
    } catch (e) {
      return [];
    }

    // ترتيب حسب آخر تحديث
    courses.sort((a, b) {
      final aDate = DateTime.tryParse(a['lastUpdated'] ?? '') ?? DateTime(2000);
      final bDate = DateTime.tryParse(b['lastUpdated'] ?? '') ?? DateTime(2000);
      return bDate.compareTo(aDate);
    });

    return courses;
  }

  // ✅ إضافة كورس للقائمة النشطة
  Future<void> addToActiveCourses(String playlistId) async {
    final activePlaylistsData = _prefs.getString('active_playlists');
    List<String> playlists = [];

    if (activePlaylistsData != null) {
      try {
        final decoded = jsonDecode(activePlaylistsData) as List<dynamic>;
        playlists = decoded.cast<String>();
      } catch (e) {
        playlists = [];
      }
    }

    if (!playlists.contains(playlistId)) {
      playlists.add(playlistId);
      await _prefs.setString('active_playlists', jsonEncode(playlists));
    }
  }

  // ✅ إزالة كورس من القائمة النشطة
  Future<void> removeFromActiveCourses(String playlistId) async {
    final activePlaylistsData = _prefs.getString('active_playlists');
    if (activePlaylistsData == null) return;

    try {
      final decoded = jsonDecode(activePlaylistsData) as List<dynamic>;
      final playlists = decoded.cast<String>();
      playlists.remove(playlistId);
      await _prefs.setString('active_playlists', jsonEncode(playlists));
    } catch (e) {
      // Handle error
    }
  }

  // ✅ مسح تقدم كورس معين
  Future<void> clearCourseProgress(String playlistId) async {
    await _prefs.remove('${_watchedVideosKey}_$playlistId');
    await _prefs.remove('${_courseInfoKey}_$playlistId');
    await removeFromActiveCourses(playlistId);
  }

  // ✅ مسح كل البيانات
  Future<void> clearAllProgress() async {
    final activePlaylistsData = _prefs.getString('active_playlists');
    if (activePlaylistsData != null) {
      try {
        final decoded = jsonDecode(activePlaylistsData) as List<dynamic>;
        final playlists = decoded.cast<String>();

        for (var playlistId in playlists) {
          await _prefs.remove('${_watchedVideosKey}_$playlistId');
          await _prefs.remove('${_courseInfoKey}_$playlistId');
        }
      } catch (e) {
        // Handle error
      }
    }

    await _prefs.remove('active_playlists');
  }

  // ✅ جلب إحصائيات عامة
  Future<Map<String, int>> getStatistics() async {
    final courses = await getActiveCourses();

    int totalCourses = courses.length;
    int totalVideosWatched = 0;
    int totalVideos = 0;

    for (var course in courses) {
      totalVideosWatched += (course['watchedVideos'] ?? 0) as int;
      totalVideos += (course['totalVideos'] ?? 0) as int;
    }

    return {
      'totalCourses': totalCourses,
      'totalVideosWatched': totalVideosWatched,
      'totalVideos': totalVideos,
    };
  }
}
