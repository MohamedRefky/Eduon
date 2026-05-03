// lib/features/profile/cubit/profile_cubit.dart

import 'dart:io';
import 'package:eduon/core/service/preferences_manager.dart';
import 'package:eduon/core/service/video_progress_service.dart';
import 'package:eduon/core/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState()) {
    _prefs.profileUpdateNotifier.addListener(loadActiveCourses);
  }

  final PreferencesManager _prefs = PreferencesManager();
  final ImagePicker _picker = ImagePicker();
  final VideoProgressService _progressService = VideoProgressService();

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

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

    emit(
      state.copyWith(
        name: name ?? '',
        selectedYear: year,
        imagePath: imagePath,
        initialImage: initialImage,
        isSaved: false,
        clearSelectedImage: true,
      ),
    );
    loadActiveCourses();
  }

  Future<void> loadActiveCourses() async {
    if (state.activeCourses.isEmpty) {
      emit(state.copyWith(isLoadingCourses: true));
    }

    final courses = await _progressService.getActiveCourses();

    emit(state.copyWith(activeCourses: courses, isLoadingCourses: false));
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateYear(String year) {
    emit(state.copyWith(selectedYear: year));
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      emit(state.copyWith(isLoadingImage: true));

      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile == null) {
        emit(state.copyWith(isLoadingImage: false));
        return;
      }

      final file = File(pickedFile.path);
      await _prefs.setUserImage(_uid, file.path);
      _prefs.notifyProfileUpdated();

      emit(
        state.copyWith(
          selectedImage: file,
          imagePath: file.path,
          isLoadingImage: false,
        ),
      );
    } catch (e) {
      debugPrint('Image pick error: $e');
      emit(state.copyWith(isLoadingImage: false));
    }
  }

  void saveProfile(String message) {
    _prefs.setUserFullName(_uid, state.name ?? '');
    _prefs.setUserSelectedYear(_uid, state.selectedYear ?? '');
    _prefs.notifyProfileUpdated();

    emit(
      state.copyWith(
        isSaved: true,
        snackBarMessage: message,
        snackBarType: SnackBarType.success,
      ),
    );
  }

  Future<void> removeCourse(String playlistId, String message) async {
    await _progressService.clearCourseProgress(playlistId);
    await loadActiveCourses();

    emit(
      state.copyWith(
        snackBarMessage: message,
        snackBarType: SnackBarType.info,
      ),
    );
  }

  void clearSnackBar() {
    emit(state.copyWith(clearSnackBar: true));
  }

  @override
  Future<void> close() {
    _prefs.profileUpdateNotifier.removeListener(loadActiveCourses);
    return super.close();
  }
}
