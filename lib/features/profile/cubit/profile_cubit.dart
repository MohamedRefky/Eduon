// lib/features/profile/cubit/profile_cubit.dart

import 'dart:io';
import 'package:eduon/core/service/prefrances_maneger.dart';
import 'package:eduon/core/service/video_progress_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  final PrefrancesManeger _prefs = PrefrancesManeger();
  final ImagePicker _picker = ImagePicker();
  final VideoProgressService _progressService = VideoProgressService();

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  /// تحميل بيانات البروفايل كلها (الاسم + السنه + الصوره + الكورسات)
  void loadProfile() {
    final name = _prefs.getUserFullName(_uid);
    final year = _prefs.getUserSelectedYear(_uid);
    final imagePath = _prefs.getUserImage(_uid);

    File? initialImage;
    if (imagePath != null) {
      final file = File(imagePath);
      if (file.existsSync()) {
        initialImage = file;
      }
    }

    emit(state.copyWith(
      name: name ?? '',
      selectedYear: year,
      imagePath: imagePath,
      initialImage: initialImage,
      isSaved: false,
      clearSelectedImage: true,
    ));

    // حمّل الكورسات كمان
    loadActiveCourses();
  }

  /// تحميل الكورسات النشطه
  Future<void> loadActiveCourses() async {
    if (state.activeCourses.isEmpty) {
      emit(state.copyWith(isLoadingCourses: true));
    }

    final courses = await _progressService.getActiveCourses();

    emit(state.copyWith(
      activeCourses: courses,
      isLoadingCourses: false,
    ));
  }

  /// تغيير الاسم (من الـ TextField)
  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  /// تغيير السنه الدراسيه
  void updateYear(String year) {
    emit(state.copyWith(selectedYear: year));
  }

  /// اختيار صوره (من الجاليري أو الكاميرا)
  Future<void> pickImage(ImageSource source) async {
    try {
      emit(state.copyWith(isLoadingImage: true));

      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile == null) {
        emit(state.copyWith(isLoadingImage: false));
        return;
      }

      final file = File(pickedFile.path);

      // احفظ المسار فى SharedPreferences
      await _prefs.setUserImage(_uid, file.path);

      emit(state.copyWith(
        selectedImage: file,
        imagePath: file.path,
        isLoadingImage: false,
      ));
    } catch (e) {
      debugPrint('Image pick error: $e');
      emit(state.copyWith(isLoadingImage: false));
    }
  }

  /// حفظ التعديلات (الاسم + السنه)
  void saveProfile() {
    _prefs.setUserFullName(_uid, state.name ?? '');
    _prefs.setUserSelectedYear(_uid, state.selectedYear ?? '');

    emit(state.copyWith(
      isSaved: true,
      snackBarMessage: 'Profile updated successfully',
      snackBarType: SnackBarType.success,
    ));
  }

  /// مسح كورس من الـ Active Learning
  Future<void> removeCourse(String playlistId) async {
    await _progressService.clearCourseProgress(playlistId);

    // أعد تحميل الكورسات
    await loadActiveCourses();

    emit(state.copyWith(
      snackBarMessage: 'Course removed successfully',
      snackBarType: SnackBarType.info,
    ));
  }

  /// مسح رساله الـ SnackBar بعد ما تتعرض
  void clearSnackBar() {
    emit(state.copyWith(clearSnackBar: true));
  }
}