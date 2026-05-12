import 'package:eduon/features/courses/bloc/courses_bloc.dart';
import 'package:eduon/features/courses/bloc/courses_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'widgets/home_header.dart';
import 'widgets/learning_path_section.dart';
import 'widgets/popular_courses_section.dart';
import 'widgets/student_guide_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          // Error
          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                HomeHeader(),

                // Student Guide
                Gap(AppSizes.h16),
                StudentGuideSection(),

                // Learning Path
                Gap(AppSizes.h16),
                LearningPathSection(),

                Gap(AppSizes.h10),
                // Popular Courses
                PopularCoursesSection(playlist: state.popularCourses),
                Gap(AppSizes.h16),
              ],
            ),
          );
        },
      ),
    );
  }
}
