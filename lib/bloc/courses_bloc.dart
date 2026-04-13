import 'package:bloc/bloc.dart' ;
import 'package:eduon/repository/course_repository.dart';
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
  }

  Future<void> _onGetAllCategories(
      GetAllCategoriesEvent event, Emitter<CoursesState> emit) async {
    try {
      emit(state.copyWith(isCategoriesLoading: true, errorMessage: null));
      final categories = await _repository.getAllCategories();
      emit(state.copyWith(
        categories: categories,
        isCategoriesLoading: false,
      ));

      // بعد ما الـ Categories تحمل، حمل الـ Popular
      add(GetPopularCoursesEvent());
    } catch (e) {
      emit(state.copyWith(
        isCategoriesLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onGetPlaylistVideos(
      GetPlaylistVideosEvent event, Emitter<CoursesState> emit) async {
    try {
      emit(state.copyWith(isPlaylistLoading: true, errorMessage: null));
      final playlist =
          await _repository.getPlaylistWithVideos(event.playlistId);
      emit(state.copyWith(
        selectedPlaylist: playlist,
        isPlaylistLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isPlaylistLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onGetPopularCourses(
      GetPopularCoursesEvent event, Emitter<CoursesState> emit) async {
    try {
      emit(state.copyWith(isPopularLoading: true));

      // لو الـ Categories محملة بالفعل، خد منها
      if (state.categories.isNotEmpty) {
        final allPlaylists = state.categories
            .expand((cat) => cat.playlists)
            .toList();

        allPlaylists.sort((a, b) => b.videoCount.compareTo(a.videoCount));

        emit(state.copyWith(
          popularCourses: allPlaylists.take(50).toList(),
          isPopularLoading: false,
        ));
      } else {
        final playlists = await _repository.getPopularCourses();
        emit(state.copyWith(
          popularCourses: playlists,
          isPopularLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isPopularLoading: false));
    }
  }
}