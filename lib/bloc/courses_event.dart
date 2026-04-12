

abstract class CoursesEvent {}

// جيب كل الـ Categories
class GetAllCategoriesEvent extends CoursesEvent {}

// جيب فيديوهات Playlist معينة
class GetPlaylistVideosEvent extends CoursesEvent {
  final String playlistId;

  GetPlaylistVideosEvent({required this.playlistId});
}

// جيب الـ Popular Courses
class GetPopularCoursesEvent extends CoursesEvent {}

// فلتر على حسب Category
class FilterByCategoryEvent extends CoursesEvent {
  final String categoryName;

  FilterByCategoryEvent({required this.categoryName});
}