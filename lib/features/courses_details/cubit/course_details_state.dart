import 'package:eduon/core/models/video_model.dart';
import 'package:equatable/equatable.dart';

enum CourseDetailsStatus { initial, loading, loaded, error }

class CourseDetailsState extends Equatable {
  final CourseDetailsStatus status;
  final List<VideoModel> videos;
  final int currentIndex;
  final bool hasMarkedAsWatched;
  final String playlistTitle;
  final String playlistId;
  final String? thumbnailUrl;
  final String? errorMessage;

  const CourseDetailsState({
    this.status = CourseDetailsStatus.initial,
    this.videos = const [],
    this.currentIndex = 0,
    this.hasMarkedAsWatched = false,
    this.playlistTitle = '',
    this.playlistId = '',
    this.thumbnailUrl,
    this.errorMessage,
  });

  VideoModel? get currentVideo =>
      videos.isNotEmpty ? videos[currentIndex] : null;

  bool get canPlayNext => currentIndex < videos.length - 1;
  bool get canPlayPrevious => currentIndex > 0;
  bool get hasVideos => videos.isNotEmpty;

  CourseDetailsState copyWith({
    CourseDetailsStatus? status,
    List<VideoModel>? videos,
    int? currentIndex,
    bool? hasMarkedAsWatched,
    String? playlistTitle,
    String? playlistId,
    String? thumbnailUrl,
    String? errorMessage,
  }) {
    return CourseDetailsState(
      status: status ?? this.status,
      videos: videos ?? this.videos,
      currentIndex: currentIndex ?? this.currentIndex,
      hasMarkedAsWatched: hasMarkedAsWatched ?? this.hasMarkedAsWatched,
      playlistTitle: playlistTitle ?? this.playlistTitle,
      playlistId: playlistId ?? this.playlistId,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        videos,
        currentIndex,
        hasMarkedAsWatched,
        playlistTitle,
        playlistId,
        thumbnailUrl,
        errorMessage,
      ];
}