import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eduon/core/service/preferences_manager.dart';
import 'student_guide_state.dart';

class StudentGuideCubit extends Cubit<StudentGuideState> {
  StudentGuideCubit() : super(StudentGuideLoading());

  Future<void> fetchSelectedYear() async {
    try {
      emit(StudentGuideLoading());
      final uid = FirebaseAuth.instance.currentUser?.uid;
      String year = 'First Year'; // Default fallback

      if (uid != null) {
        final savedYear = PreferencesManager().getUserSelectedYear(uid);
        if (savedYear != null && savedYear.isNotEmpty) {
          year = _normalizeYear(savedYear);
        }
      }

      emit(StudentGuideLoaded(year));
    } catch (e) {
      emit(StudentGuideError(e.toString()));
    }
  }

  /// Change the year, persist it, and notify the rest of the app
  Future<void> changeYear(String newYear) async {
    final normalized = _normalizeYear(newYear);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await PreferencesManager().setUserSelectedYear(uid, normalized);
      // Notify home, profile, and any widget listening to profileUpdateNotifier
      PreferencesManager().notifyProfileUpdated();
    }
    emit(StudentGuideLoaded(normalized));
  }

  /// Converts any localized year string to the fixed English key used in yearSubjectsData
  String _normalizeYear(String year) {
    if (year.contains('1') || year.toLowerCase().contains('first') || year.contains('الأولى')) {
      return 'First Year';
    }
    if (year.contains('2') || year.toLowerCase().contains('second') || year.contains('الثانية')) {
      return 'Second Year';
    }
    if (year.contains('3') || year.toLowerCase().contains('third') || year.contains('الثالثة')) {
      return 'Third Year';
    }
    if (year.contains('4') || year.toLowerCase().contains('fourth') || year.contains('الرابعة')) {
      return 'Fourth Year';
    }
    return year;
  }
}
