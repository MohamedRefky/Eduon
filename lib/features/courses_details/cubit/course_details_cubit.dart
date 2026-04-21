
import 'package:eduon/core/service/video_progress_service.dart';
import 'package:eduon/features/courses/repository/course_repository.dart';
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
  })  : _repository = repository ?? CourseRepository(),
        _progressService = progressService ?? VideoProgressService(),
        super(const CourseDetailsState());

  /// تحميل الفيديوهات
  Future<void> loadPlaylistVideos() async {
    emit(state.copyWith(
      status: CourseDetailsStatus.loading,
      playlistId: playlistId,
    ));

    try {
      final playlist = await _repository.getPlaylistWithVideos(playlistId);

      if ( playlist.videos.isEmpty) {
        emit(state.copyWith(
          status: CourseDetailsStatus.error,
          errorMessage: 'No videos found',
        ));
        return;
      }

      emit(state.copyWith(
        status: CourseDetailsStatus.loaded,
        videos: playlist.videos,
        playlistTitle: playlist.title,
        thumbnailUrl: playlist.thumbnailUrl,
        playlistId: playlist.playlistId,
      ));

      await _saveCourseInfo();
    } catch (e) {
      emit(state.copyWith(
        status: CourseDetailsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// حفظ معلومات الكورس
  Future<void> _saveCourseInfo() async {
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

    emit(state.copyWith(
      currentIndex: index,
      hasMarkedAsWatched: false,
    ));
  }

  /// التالي
  void playNext() {
    if (state.canPlayNext) {
      playVideo(state.currentIndex + 1);
    }
  }

  /// السابق
  void playPrevious() {
    if (state.canPlayPrevious) {
      playVideo(state.currentIndex - 1);
    }
  }

  /// تحديث الوقت
  void onPositionChanged({
    required int currentSeconds,
    required int totalSeconds,
  }) {
    if (!state.hasVideos) return;

    _autoSaveProgress(currentSeconds, totalSeconds);
    _autoMarkAsWatched(currentSeconds, totalSeconds);
  }

  /// حفظ التقدم كل 5 ثواني
  void _autoSaveProgress(int currentSeconds, int totalSeconds) {
    if (currentSeconds <= 0) return;
    if (currentSeconds % 5 != 0) return;
    if (currentSeconds == _lastSavedSecond) return;

    _lastSavedSecond = currentSeconds;

    _progressService.saveVideoPosition(
      state.currentVideo!.videoId,
      currentSeconds,
      totalSeconds,
    );
  }

  /// لو وصل 90% يتحسب مكتمل
  void _autoMarkAsWatched(int currentSeconds, int totalSeconds) {
    if (state.hasMarkedAsWatched) return;
    if (totalSeconds <= 0) return;

    final progress = currentSeconds / totalSeconds;

    if (progress >= 0.9) {
      _markAsWatched();
    }
  }

  /// تسجيل الفيديو كمكتمل
  Future<void> _markAsWatched() async {
    if (state.hasMarkedAsWatched || state.currentVideo == null) return;

    emit(state.copyWith(hasMarkedAsWatched: true));

    await _progressService.markAsWatched(
      state.playlistId,
      state.currentVideo!.videoId,
    );
  }

  /// حفظ التقدم الحالي
  Future<void> saveCurrentProgress({
    required int positionSeconds,
    required int durationSeconds,
  }) async {
    if (state.currentVideo == null) return;

    await _progressService.saveVideoPosition(
      state.currentVideo!.videoId,
      positionSeconds,
      durationSeconds,
    );
  }

  /// Format helpers
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
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

}