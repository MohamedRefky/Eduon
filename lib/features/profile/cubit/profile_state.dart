import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:eduon/core/widgets/custom_snack_bar.dart';

class ProfileState extends Equatable {
  final String? name;
  final String? selectedYear;
  final String? imagePath;
  final File? selectedImage;
  final File? initialImage;
  final bool isLoadingImage;
  final bool isSaved;
  final List<Map<String, dynamic>> activeCourses;
  final bool isLoadingCourses;
  final String? snackBarMessage;
  final SnackBarType? snackBarType;

  const ProfileState({
    this.name,
    this.selectedYear,
    this.imagePath,
    this.selectedImage,
    this.initialImage,
    this.isLoadingImage = false,
    this.isSaved = false,
    this.activeCourses = const [],
    this.isLoadingCourses = true,
    this.snackBarMessage,
    this.snackBarType,
  });
  File? get displayImage => selectedImage ?? initialImage;

  ProfileState copyWith({
    String? name,
    String? selectedYear,
    String? imagePath,
    File? selectedImage,
    File? initialImage,
    bool? isLoadingImage,
    bool? isSaved,
    List<Map<String, dynamic>>? activeCourses,
    bool? isLoadingCourses,
    String? snackBarMessage,
    SnackBarType? snackBarType,
    bool clearSnackBar = false,
    bool clearSelectedImage = false,
  }) {
    return ProfileState(
      name: name ?? this.name,
      selectedYear: selectedYear ?? this.selectedYear,
      imagePath: imagePath ?? this.imagePath,
      selectedImage: clearSelectedImage ? null : (selectedImage ?? this.selectedImage),
      initialImage: initialImage ?? this.initialImage,
      isLoadingImage: isLoadingImage ?? this.isLoadingImage,
      isSaved: isSaved ?? this.isSaved,
      activeCourses: activeCourses ?? this.activeCourses,
      isLoadingCourses: isLoadingCourses ?? this.isLoadingCourses,
      snackBarMessage: clearSnackBar ? null : (snackBarMessage ?? this.snackBarMessage),
      snackBarType: clearSnackBar ? null : (snackBarType ?? this.snackBarType),
    );
  }

  @override
  List<Object?> get props => [
        name,
        selectedYear,
        imagePath,
        selectedImage,
        initialImage,
        isLoadingImage,
        isSaved,
        activeCourses,
        isLoadingCourses,
        snackBarMessage,
        snackBarType,
      ];
}