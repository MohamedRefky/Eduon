import 'package:eduon/features/courses/data/models/category_model.dart';
import 'package:eduon/features/courses/data/models/playlist_model.dart';

class CoursesState {
  final List<CategoryModel> categories;
  final List<PlaylistModel> popularCourses;
  final PlaylistModel? selectedPlaylist;
  final List<PlaylistModel> allPlaylists;
  final List<PlaylistModel> filteredPlaylists;
  final String searchQuery;
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
    this.searchQuery = '',
    this.allPlaylists = const [],
    this.filteredPlaylists = const [],
  });

  CoursesState copyWith({
    List<CategoryModel>? categories,
    List<PlaylistModel>? popularCourses,
    PlaylistModel? selectedPlaylist,
    bool? isCategoriesLoading,
    bool? isPopularLoading,
    bool? isPlaylistLoading,
    String? errorMessage,
    List<PlaylistModel>? allPlaylists,
    List<PlaylistModel>? filteredPlaylists,
    String? searchQuery,
  }) {
    return CoursesState(
      categories: categories ?? this.categories,
      popularCourses: popularCourses ?? this.popularCourses,
      selectedPlaylist: selectedPlaylist ?? this.selectedPlaylist,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isPopularLoading: isPopularLoading ?? this.isPopularLoading,
      isPlaylistLoading: isPlaylistLoading ?? this.isPlaylistLoading,
      errorMessage: errorMessage,
      allPlaylists: allPlaylists ?? this.allPlaylists,
      filteredPlaylists: filteredPlaylists ?? this.filteredPlaylists,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
