import 'package:eduon/core/service/video_progress_service.dart';
import 'package:eduon/repository/course_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  final CourseRepository _repository;
  final VideoProgressService _progressService;
  final String playlistId;

  int _lastSavedSecond = -1;

  CourseDetailsCubit({
    required this.playlistId,
    CourseRepository? repository,
    VideoProgressService? progressService,
  }) : _repository = repository ?? CourseRepository(),
       _progressService = progressService ?? VideoProgressService(),
       super(const CourseDetailsState());

  /// ✅ الحل الحقيقي - try catch على emit نفسه
  void _safeEmit(CourseDetailsState newState) {
    try {
      if (!isClosed) {
        emit(newState);
      }
    } catch (e) {
      debugPrint('SafeEmit caught: $e');
    }
  }

  /// تحميل الفيديوهات
  Future<void> loadPlaylistVideos() async {
    emit(
      state.copyWith(
        status: CourseDetailsStatus.loading,
        playlistId: playlistId,
      ),
    );

    try {
      final playlist = await _repository.getPlaylistWithVideos(playlistId);

      if (isClosed) return;

      if (playlist.videos.isEmpty) {
        if (isClosed) return;

        emit(
          state.copyWith(
            status: CourseDetailsStatus.error,
            errorMessage: 'No videos found',
          ),
        );
        return;
      }

      if (isClosed) return;

      emit(
        state.copyWith(
          status: CourseDetailsStatus.loaded,
          videos: playlist.videos,
          playlistTitle: playlist.title,
          thumbnailUrl: playlist.thumbnailUrl,
          playlistId: playlist.playlistId,
        ),
      );

      if (!isClosed) {
        await _saveCourseInfo();
      }
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          status: CourseDetailsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _saveCourseInfo() async {
    if (isClosed) return;

    await _progressService.saveCourseInfo(
      state.playlistId,
      state.playlistTitle,
      state.videos.length,
      state.thumbnailUrl,
    );

    await _progressService.addToActiveCourses(state.playlistId);
  }

  /// تشغيل فيديو معين
  void playVideo(int index) {
    if (index < 0 || index >= state.videos.length) return;
    _lastSavedSecond = -1;
    _safeEmit(state.copyWith(currentIndex: index, hasMarkedAsWatched: false));
  }

  void playNext() {
    if (state.canPlayNext) playVideo(state.currentIndex + 1);
  }

  void playPrevious() {
    if (state.canPlayPrevious) playVideo(state.currentIndex - 1);
  }

  void onPositionChanged({
    required int currentSeconds,
    required int totalSeconds,
  }) {
    if (!state.hasVideos) return;
    _autoSaveProgress(currentSeconds, totalSeconds);
    _autoMarkAsWatched(currentSeconds, totalSeconds);
  }

  void _autoSaveProgress(int currentSeconds, int totalSeconds) {
    if (isClosed) return;
    if (currentSeconds <= 0) return;
    if (currentSeconds % 5 != 0) return;
    if (currentSeconds == _lastSavedSecond) return;
    if (state.currentVideo == null) return;

    _lastSavedSecond = currentSeconds;

    _progressService.saveVideoPosition(
      state.currentVideo!.videoId,
      currentSeconds,
      totalSeconds,
    );
  }

  void _autoMarkAsWatched(int currentSeconds, int totalSeconds) {
    if (state.hasMarkedAsWatched) return;
    if (totalSeconds <= 0) return;

    final progress = currentSeconds / totalSeconds;
    if (progress >= 0.9) {
      _markAsWatched();
    }
  }

  Future<void> _markAsWatched() async {
    if (isClosed) return;
    if (state.hasMarkedAsWatched || state.currentVideo == null) return;

    _safeEmit(state.copyWith(hasMarkedAsWatched: true));

    try {
      await _progressService.markAsWatched(
        state.playlistId,
        state.currentVideo!.videoId,
      );
    } catch (e) {
      debugPrint('markAsWatched error: $e');
    }
  }

  Future<void> saveCurrentProgress({
    required int positionSeconds,
    required int durationSeconds,
  }) async {
    if (isClosed) return;
    if (state.currentVideo == null) return;

    try {
      await _progressService.saveVideoPosition(
        state.currentVideo!.videoId,
        positionSeconds,
        durationSeconds,
      );
    } catch (e) {
      debugPrint('saveCurrentProgress error: $e');
    }
  }

  String formatViewCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  String formatDuration(String duration) {
    if (duration.isEmpty) return '';

    final regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
    final match = regex.firstMatch(duration);
    if (match == null) return '';

    final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
    final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;
    final seconds = int.tryParse(match.group(3) ?? '0') ?? 0;

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
