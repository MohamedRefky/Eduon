import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'prefrances_maneger.dart';

class VideoProgressService {
  final PrefrancesManeger _prefs = PrefrancesManeger();

  static const String _watchedVideosKey = 'watched_videos';
  static const String _videoProgressKey = 'video_progress';
  static const String _courseInfoKey = 'course';

  // 🔥 NEW: UID helper (used to isolate data per user)
  String? _uid() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  // =========================
  // ✅ Mark video as watched
  // =========================
  Future<void> markAsWatched(String playlistId, String videoId) async {
    final watchedList = await getWatchedVideos(playlistId);

    if (!watchedList.contains(videoId)) {
      watchedList.add(videoId);
    }

    // 🔥 MODIFIED: added UID to isolate user data
    final key = '${_watchedVideosKey}_${_uid()}_$playlistId';

    await _prefs.setString(key, jsonEncode(watchedList));
  }

  // =========================
  // ✅ Get watched videos for a course
  // =========================
  Future<List<String>> getWatchedVideos(String playlistId) async {
    // 🔥 MODIFIED: added UID to isolate user data
    final key = '${_watchedVideosKey}_${_uid()}_$playlistId';

    final data = _prefs.getString(key);

    if (data == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(data);
      return decoded.cast<String>();
    } catch (e) {
      return [];
    }
  }

  // =========================
  // ✅ Calculate course progress
  // =========================
  Future<double> getCourseProgress(String playlistId, int totalVideos) async {
    final watchedVideos = await getWatchedVideos(playlistId);
    if (totalVideos == 0) return 0.0;
    return watchedVideos.length / totalVideos;
  }

  // =========================
  // ✅ Save video playback position (resume feature)
  // =========================
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

    // 🔥 MODIFIED: added UID to isolate user data
    await _prefs.setString(
      '${_videoProgressKey}_${_uid()}_$videoId',
      jsonEncode(progressData),
    );
  }

  // =========================
  // ✅ Get last saved video position
  // =========================
  Future<int?> getVideoPosition(String videoId) async {
    // 🔥 MODIFIED: added UID to isolate user data
    final data = _prefs.getString('${_videoProgressKey}_${_uid()}_$videoId');

    if (data == null) return null;

    try {
      final progressData = jsonDecode(data);
      return progressData['position'] as int?;
    } catch (e) {
      return null;
    }
  }

  // =========================
  // ✅ Check if video is watched
  // =========================
  Future<bool> isVideoWatched(String playlistId, String videoId) async {
    final watchedList = await getWatchedVideos(playlistId);
    return watchedList.contains(videoId);
  }

  // =========================
  // ✅ Save course information
  // =========================
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

    // 🔥 MODIFIED: added UID to isolate user data
    await _prefs.setString(
      '${_courseInfoKey}_${_uid()}_$playlistId',
      jsonEncode(courseData),
    );
  }

  // =========================
  // ✅ Get course information
  // =========================
  Future<Map<String, dynamic>?> getCourseInfo(String playlistId) async {
    // 🔥 MODIFIED: added UID to isolate user data
    final data = _prefs.getString('${_courseInfoKey}_${_uid()}_$playlistId');

    if (data == null) return null;

    try {
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // =========================
  // ⚠️ Get active courses (user-specific)
  // =========================
  Future<List<Map<String, dynamic>>> getActiveCourses() async {
    List<Map<String, dynamic>> courses = [];

    // 🔥 MODIFIED: user-specific active playlists
    final activePlaylistsData = _prefs.getString('active_playlists_${_uid()}');

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

    // Sort by last updated
    courses.sort((a, b) {
      final aDate = DateTime.tryParse(a['lastUpdated'] ?? '') ?? DateTime(2000);
      final bDate = DateTime.tryParse(b['lastUpdated'] ?? '') ?? DateTime(2000);
      return bDate.compareTo(aDate);
    });

    return courses;
  }

  // =========================
  // ⚠️ Add course to active list (user-specific)
  // =========================
  Future<void> addToActiveCourses(String playlistId) async {
    // 🔥 MODIFIED: user-specific key
    final activePlaylistsData = _prefs.getString('active_playlists_${_uid()}');

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

      await _prefs.setString(
        'active_playlists_${_uid()}',
        jsonEncode(playlists),
      );
    }
  }

  // =========================
  // ⚠️ Remove course from active list (user-specific)
  // =========================
  Future<void> removeFromActiveCourses(String playlistId) async {
    // 🔥 MODIFIED: user-specific key
    final activePlaylistsData = _prefs.getString('active_playlists_${_uid()}');

    if (activePlaylistsData == null) return;

    try {
      final decoded = jsonDecode(activePlaylistsData) as List<dynamic>;
      final playlists = decoded.cast<String>();
      playlists.remove(playlistId);

      await _prefs.setString(
        'active_playlists_${_uid()}',
        jsonEncode(playlists),
      );
    } catch (e) {
      return;
    }
  }

  // =========================
  // ⚠️ Clear course progress
  // =========================
  Future<void> clearCourseProgress(String playlistId) async {
    await _prefs.remove('${_watchedVideosKey}_${_uid()}_$playlistId');
    await _prefs.remove('${_courseInfoKey}_${_uid()}_$playlistId');
    await removeFromActiveCourses(playlistId);
  }

  // =========================
  // ⚠️ Clear all user progress
  // =========================
  Future<void> clearAllProgress() async {
    final activePlaylistsData = _prefs.getString('active_playlists_${_uid()}');

    if (activePlaylistsData != null) {
      try {
        final decoded = jsonDecode(activePlaylistsData) as List<dynamic>;
        final playlists = decoded.cast<String>();

        for (var playlistId in playlists) {
          await _prefs.remove('${_watchedVideosKey}_${_uid()}_$playlistId');
          await _prefs.remove('${_courseInfoKey}_${_uid()}_$playlistId');
        }
      } catch (e) {
        return;
      }
    }

    await _prefs.remove('active_playlists_${_uid()}');
  }

  // =========================
  // ✅ Get general statistics
  // =========================
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
