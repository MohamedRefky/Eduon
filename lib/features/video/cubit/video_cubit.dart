import 'package:eduon/core/service/video_progress_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideoProgressService _progressService;

  final String videoId;
  final String playlistId;
  final String playlistTitle;
  final int totalVideos;
  final String? thumbnailUrl;

  int _lastSavedSecond = -1;

  VideoCubit({
    required this.videoId,
    required this.playlistId,
    required this.playlistTitle,
    required this.totalVideos,
    this.thumbnailUrl,
    VideoProgressService? progressService,
  })  : _progressService = progressService ?? VideoProgressService(),
        super(const VideoState());


  Future<void> initialize() async {
    emit(state.copyWith(status: VideoStatus.loading));

    try {
      await _progressService.saveCourseInfo(
        playlistId,
        playlistTitle,
        totalVideos,
        thumbnailUrl,
      );

      await _progressService.addToActiveCourses(playlistId);

      final position = await _progressService.getVideoPosition(videoId);

      emit(state.copyWith(
        status: VideoStatus.ready,
        resumeFromSeconds: (position != null && position > 5) ? position : null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: VideoStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void onPlayerReady() {
    emit(state.copyWith(isPlayerReady: true));
  }


  void onPositionChanged({
    required int currentSeconds,
    required int totalSeconds,
  }) {
    if (!state.isPlayerReady) return;

   
    if (currentSeconds == state.currentPositionSeconds) return;

    emit(state.copyWith(
      currentPositionSeconds: currentSeconds,
      totalDurationSeconds: totalSeconds,
    ));

    _autoSaveProgress(currentSeconds, totalSeconds);
    _autoMarkAsWatched(currentSeconds, totalSeconds);
  }


  void _autoSaveProgress(int currentSeconds, int totalSeconds) {
    if (currentSeconds <= 0) return;
    if (currentSeconds % 5 != 0) return;
    if (currentSeconds == _lastSavedSecond) return;

    _lastSavedSecond = currentSeconds;

    _progressService.saveVideoPosition(
      videoId,
      currentSeconds,
      totalSeconds,
    );
  }


  void _autoMarkAsWatched(int currentSeconds, int totalSeconds) {
    if (state.hasMarkedAsWatched) return;
    if (totalSeconds <= 0) return;

    final progress = currentSeconds / totalSeconds;

    if (progress >= 0.9) {
      markAsWatched();
    }
  }


  Future<void> markAsWatched() async {
    if (state.hasMarkedAsWatched) return;

    emit(state.copyWith(hasMarkedAsWatched: true));
    await _progressService.markAsWatched(playlistId, videoId);
  }


  Future<void> saveCurrentProgress() async {
    await _progressService.saveVideoPosition(
      videoId,
      state.currentPositionSeconds,
      state.totalDurationSeconds,
    );
  }

  @override
  Future<void> close() {
    saveCurrentProgress();
    return super.close();
  }
}