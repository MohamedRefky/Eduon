import 'package:equatable/equatable.dart';

enum VideoStatus { initial, loading, ready, error }

class VideoState extends Equatable {
  final VideoStatus status;
  final bool isPlayerReady;
  final bool hasMarkedAsWatched;
  final int currentPositionSeconds;
  final int totalDurationSeconds;
  final int? resumeFromSeconds;
  final String? errorMessage;

  const VideoState({
    this.status = VideoStatus.initial,
    this.isPlayerReady = false,
    this.hasMarkedAsWatched = false,
    this.currentPositionSeconds = 0,
    this.totalDurationSeconds = 0,
    this.resumeFromSeconds,
    this.errorMessage,
  });

  double get progressPercent {
    if (totalDurationSeconds <= 0) return 0.0;
    return currentPositionSeconds / totalDurationSeconds;
  }

  bool get isCompleted => progressPercent >= 0.9;

  String get currentTimeFormatted => _format(currentPositionSeconds);
  String get totalTimeFormatted => _format(totalDurationSeconds);

  String _format(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  VideoState copyWith({
    VideoStatus? status,
    bool? isPlayerReady,
    bool? hasMarkedAsWatched,
    int? currentPositionSeconds,
    int? totalDurationSeconds,
    int? resumeFromSeconds,
    String? errorMessage,
  }) {
    return VideoState(
      status: status ?? this.status,
      isPlayerReady: isPlayerReady ?? this.isPlayerReady,
      hasMarkedAsWatched: hasMarkedAsWatched ?? this.hasMarkedAsWatched,
      currentPositionSeconds:
          currentPositionSeconds ?? this.currentPositionSeconds,
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
      resumeFromSeconds: resumeFromSeconds ?? this.resumeFromSeconds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isPlayerReady,
        hasMarkedAsWatched,
        currentPositionSeconds,
        totalDurationSeconds,
        resumeFromSeconds,
        errorMessage,
      ];
}