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
                // Categories Tabs
                _buildCategoryTabs(),

                // Courses by Category
                //_buildCategoryCourses(state),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryTabs() {
    final categories = ['Tech', 'Design', 'Business', 'Soft Skills'];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? Colors.deepPurple : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

//   Widget _buildCategoryCourses(CoursesState state) {
//     // Loading
//     if (state.isCategoriesLoading) {
//       return const SizedBox(
//         height: 200,
//         child: Center(child: CircularProgressIndicator()),
//       );
//     }

//     // لو مفيش Categories
//     if (state.categories.isEmpty) return const SizedBox();

//     // فلتر على حسب الـ Category المختارة
//     final category = state.categories.firstWhere(
//       (cat) => cat.name == selectedCategory,
//       orElse: () => state.categories.first,
//     );

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: Text(
//             '$selectedCategory Courses',
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         SizedBox(
//           height: 200,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: category.playlists.length,
//             itemBuilder: (context, index) =>
//                 PopularCoursesSection(playlist: category.playlists),
//           ),
//         ),
//       ],
//     );
//   }
}
