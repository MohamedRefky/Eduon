import 'package:eduon/bloc/courses_bloc.dart';
import 'package:eduon/bloc/courses_event.dart';
import 'package:eduon/bloc/courses_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/repository/course_repository.dart';
import 'package:eduon/screens/home/widgets/home_header.dart';
import 'package:eduon/screens/home/widgets/learning_path_section.dart';
import 'package:eduon/screens/home/widgets/student_Guide_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'widgets/popular_courses_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CoursesBloc(repository: CourseRepository())
            ..add(GetAllCategoriesEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCategory = 'Tech';

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
                Gap(AppSizes.h20),

                // Student Guide
                StudentGuideSection(),
                Gap(AppSizes.h20),
                LearningPathSection(),

                Gap(AppSizes.h20),
                // Popular Courses
                PopularCoursesSection(playlist: state.popularCourses),

                Gap(AppSizes.h20),
              ],
            ),
          );
        },
      ),
    );
  }
}
