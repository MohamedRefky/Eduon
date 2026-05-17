import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/student_guide_cubit.dart';
import '../cubit/student_guide_state.dart';
import '../widgets/subject_list.dart';

class StudentGuideScreen extends StatelessWidget {
  const StudentGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => StudentGuideCubit()..fetchSelectedYear(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, size: AppSizes.sp24),
              ),
              title: Text(l10n.student_guide),
            ),
            body: BlocBuilder<StudentGuideCubit, StudentGuideState>(
              builder: (context, state) => switch (state) {
                StudentGuideLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                StudentGuideError(:final message) => Center(
                  child: Text(message),
                ),
                StudentGuideLoaded(:final selectedYear) => SubjectList(
                  selectedYear: selectedYear,
                ),
                _ => const SizedBox(),
              },
            ),
          );
        },
      ),
    );
  }
}
