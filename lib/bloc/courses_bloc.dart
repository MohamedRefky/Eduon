import 'package:bloc/bloc.dart' ;
import 'package:eduon/repository/course_repository.dart';
import 'courses_event.dart';
import 'courses_state.dart';



class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final CourseRepository _repository;

  CoursesBloc({required CourseRepository repository})
      : _repository = repository,
        super(Initial()) {
    on<GetAllCategoriesEvent>(_onGetAllCategories);
    on<GetPlaylistVideosEvent>(_onGetPlaylistVideos);
    on<GetPopularCoursesEvent>(_onGetPopularCourses);
  }

  Future<void> _onGetAllCategories(
      GetAllCategoriesEvent event, Emitter<CoursesState> emit) async {
    try {
      emit(AllCategoriesLoading());
      final categories = await _repository.getAllCategories();
      emit(AllCategoriesLoaded(categories: categories));
    } catch (e) {
      emit(CoursesError(errorMessage: e.toString()));
    }
  }

  Future<void> _onGetPlaylistVideos(
      GetPlaylistVideosEvent event, Emitter<CoursesState> emit) async {
    try {
      emit(PlaylistLoading());
      // بنبعت الـ ID بس والـ Repository بيعمل كل حاجة
      final playlist =
          await _repository.getPlaylistWithVideos(event.playlistId);
      emit(PlaylistLoaded(playlist: playlist));
    } catch (e) {
      emit(CoursesError(errorMessage: e.toString()));
    }
  }

  Future<void> _onGetPopularCourses(
      GetPopularCoursesEvent event, Emitter<CoursesState> emit) async {
    try {
      emit(PopularCoursesLoading());
      final playlists = await _repository.getPopularCourses();
      emit(PopularCoursesLoaded(playlists: playlists));
    } catch (e) {
      emit(CoursesError(errorMessage: e.toString()));
    }
  }
}