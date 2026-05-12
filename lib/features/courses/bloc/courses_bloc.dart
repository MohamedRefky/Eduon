import 'package:bloc/bloc.dart';
import 'package:eduon/features/courses/data/course_repository.dart';

import 'courses_event.dart';
import 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final CourseRepository _repository;

  CoursesBloc({required CourseRepository repository})
    : _repository = repository,
      super(CoursesState()) {
    on<GetAllCategoriesEvent>(_onGetAllCategories);
    on<GetPlaylistVideosEvent>(_onGetPlaylistVideos);
    on<GetPopularCoursesEvent>(_onGetPopularCourses);
    on<SearchPlaylistsEvent>(_onSearchPlaylists);
  }

  Future<void> _onGetAllCategories(
    GetAllCategoriesEvent event,
    Emitter<CoursesState> emit,
  ) async {
    try {
      emit(state.copyWith(isCategoriesLoading: true, errorMessage: null));
      final categories = await _repository.getAllCategories();
      final allPlaylists = categories.expand((cat) => cat.playlists).toList();

      emit(
        state.copyWith(
          categories: categories,
          allPlaylists: allPlaylists,
          filteredPlaylists: allPlaylists,
          isCategoriesLoading: false,
        ),
      );

      add(GetPopularCoursesEvent());
    } catch (e) {
      emit(
        state.copyWith(isCategoriesLoading: false, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onGetPlaylistVideos(
    GetPlaylistVideosEvent event,
    Emitter<CoursesState> emit,
  ) async {
    try {
      emit(state.copyWith(isPlaylistLoading: true, errorMessage: null));
      final playlist = await _repository.getPlaylistWithVideos(
        event.playlistId,
      );
      emit(
        state.copyWith(selectedPlaylist: playlist, isPlaylistLoading: false),
      );
    } catch (e) {
      emit(
        state.copyWith(isPlaylistLoading: false, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onGetPopularCourses(
    GetPopularCoursesEvent event,
    Emitter<CoursesState> emit,
  ) async {
    try {
      emit(state.copyWith(isPopularLoading: true));
      if (state.categories.isNotEmpty) {
        final allPlaylists = state.categories
            .expand((cat) => cat.playlists)
            .toList();

        allPlaylists.sort((a, b) => b.videoCount.compareTo(a.videoCount));

        emit(
          state.copyWith(
            popularCourses: allPlaylists.take(50).toList(),
            isPopularLoading: false,
          ),
        );
      } else {
        final playlists = await _repository.getPopularCourses();
        emit(
          state.copyWith(popularCourses: playlists, isPopularLoading: false),
        );
      }
    } catch (e) {
      emit(state.copyWith(isPopularLoading: false));
    }
  }

  Future<void> _onSearchPlaylists(
    SearchPlaylistsEvent event,
    Emitter<CoursesState> emit,
  ) async {
    final query = event.query.toLowerCase().trim();
    if (query.isEmpty) {
      emit(
        state.copyWith(searchQuery: '', filteredPlaylists: state.allPlaylists),
      );
      return;
    }

    final filtered = state.allPlaylists.where((playlist) {
      return playlist.title.toLowerCase().contains(query) ||
          playlist.category.toLowerCase().contains(query) ||
          playlist.channelTitle.toLowerCase().contains(query) ||
          playlist.description.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(searchQuery: event.query, filteredPlaylists: filtered));
  }
}
