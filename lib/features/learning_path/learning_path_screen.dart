import 'package:eduon/features/courses/bloc/courses_bloc.dart';
import 'package:eduon/features/courses/bloc/courses_event.dart';
import 'package:eduon/features/courses/bloc/courses_state.dart';
import 'package:eduon/features/learning_path/data/models/learning_path_model.dart';
import 'package:eduon/features/courses/data/course_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eduon/l10n/app_localizations.dart';

import 'widgets/learning_path_header.dart';
import 'widgets/learning_path_roadmap_section.dart';

class LearningPathScreen extends StatelessWidget {
  final LearningPathModel learningPath;

  const LearningPathScreen({super.key, required this.learningPath});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CoursesBloc(repository: CourseRepository())
            ..add(GetAllCategoriesEvent()),
      child: LearningPathView(learningPath: learningPath),
    );
  }
}

class LearningPathView extends StatelessWidget {
  final LearningPathModel learningPath;

  const LearningPathView({super.key, required this.learningPath});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.learning_path)),
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          return Column(
            children: [
              // Header
              LearningPathHeader(learningPath: learningPath),

              // Courses List
              LearningPathRoadmapSection(
                learningPath: learningPath,
                state: state,
              ),
            ],
          );
        },
      ),
    );
  }
}
