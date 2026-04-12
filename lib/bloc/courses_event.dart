

abstract class CoursesEvent {}

class GetAllCategoriesEvent extends CoursesEvent {}

class GetPlaylistVideosEvent extends CoursesEvent {
  final String playlistId;
  GetPlaylistVideosEvent({required this.playlistId});
}

class GetPopularCoursesEvent extends CoursesEvent {}