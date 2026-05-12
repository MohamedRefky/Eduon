import 'package:equatable/equatable.dart';

abstract class StudentGuideState extends Equatable {
  const StudentGuideState();

  @override
  List<Object?> get props => [];
}

class StudentGuideLoading extends StudentGuideState {}

class StudentGuideLoaded extends StudentGuideState {
  final String selectedYear;

  const StudentGuideLoaded(this.selectedYear);

  @override
  List<Object?> get props => [selectedYear];
}

class StudentGuideError extends StudentGuideState {
  final String message;

  const StudentGuideError(this.message);

  @override
  List<Object?> get props => [message];
}
