import 'package:eduon/core/models/category_model.dart';
import 'package:eduon/core/models/playlist_model.dart';

class CoursesState {
  final List<CategoryModel> categories;
  final List<PlaylistModel> popularCourses;
  final PlaylistModel? selectedPlaylist;
  final bool isCategoriesLoading;
  final bool isPopularLoading;
  final bool isPlaylistLoading;
  final String? errorMessage;

  CoursesState({
    this.categories = const [],
    this.popularCourses = const [],
    this.selectedPlaylist,
    this.isCategoriesLoading = false,
    this.isPopularLoading = false,
    this.isPlaylistLoading = false,
    this.errorMessage,
  });

  CoursesState copyWith({
    List<CategoryModel>? categories,
    List<PlaylistModel>? popularCourses,
    PlaylistModel? selectedPlaylist,
    bool? isCategoriesLoading,
    bool? isPopularLoading,
    bool? isPlaylistLoading,
    String? errorMessage,
  }) {
    return CoursesState(
      categories: categories ?? this.categories,
      popularCourses: popularCourses ?? this.popularCourses,
      selectedPlaylist: selectedPlaylist ?? this.selectedPlaylist,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isPopularLoading: isPopularLoading ?? this.isPopularLoading,
      isPlaylistLoading: isPlaylistLoading ?? this.isPlaylistLoading,
      errorMessage: errorMessage,
    );
  }
}