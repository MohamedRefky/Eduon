import 'package:eduon/core/models/category_model.dart';
import 'package:eduon/core/models/playlist_model.dart';

abstract class CoursesState {}

class Initial extends CoursesState {}

class AllCategoriesLoading extends CoursesState {}

class AllCategoriesLoaded extends CoursesState {
  final List<CategoryModel> categories;
  AllCategoriesLoaded({required this.categories});
}

class PlaylistLoading extends CoursesState {}

class PlaylistLoaded extends CoursesState {
  final PlaylistModel playlist;
  PlaylistLoaded({required this.playlist});
}

class PopularCoursesLoading extends CoursesState {}

class PopularCoursesLoaded extends CoursesState {
  final List<PlaylistModel> playlists;
  PopularCoursesLoaded({required this.playlists});
}

class CoursesError extends CoursesState {
  final String errorMessage;
  CoursesError({required this.errorMessage});
}