import 'package:eduon/bloc/courses_bloc.dart';
import 'package:eduon/bloc/courses_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'widgets/category_filter_grid.dart';
import 'widgets/courses_count_header.dart';
import 'widgets/courses_list_view.dart';
import 'widgets/header_section.dart';
import 'widgets/search_field_widget.dart';

class ViewAllCoursesScreen extends StatefulWidget {
  const ViewAllCoursesScreen({super.key});

  @override
  State<ViewAllCoursesScreen> createState() => _ViewAllCoursesScreenState();
}

class _ViewAllCoursesScreenState extends State<ViewAllCoursesScreen> {
  String _selectedCategory = 'All';

  void _onCategoryTap(String category) {
    setState(() {
      _selectedCategory = _selectedCategory == category ? 'All' : category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          if (state.isCategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
            );
          }

          final allCourses = state.categories
              .expand((cat) => cat.playlists)
              .toList();

          final filteredCourses = _selectedCategory == 'All'
              ? allCourses
              : allCourses
                  .where((p) => p.category == _selectedCategory)
                  .toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderSection(),
                      Gap(AppSizes.h16),
                      const SearchFieldWidget(),
                      Gap(AppSizes.h16),

                      // Category Filter (Business - Design - Tech - Soft Skills)
                      CategoryFilterGrid(
                        selectedCategory: _selectedCategory,
                        onCategoryTap: _onCategoryTap,
                      ),

                      Gap(AppSizes.h8),
                    ],
                  ),
                ),
              ),

              //  Count Header  full width)
              SliverToBoxAdapter(
                child: CoursesCountHeader(
                  count: filteredCourses.length,
                  selectedCategory: _selectedCategory,
                  onClear: () => setState(() => _selectedCategory = 'All'),
                ),
              ),

              //  Courses List
              filteredCourses.isEmpty
                  ? SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.school_outlined,
                                size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('No courses found',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index == filteredCourses.length - 1
                                    ? AppSizes.h16
                                    : AppSizes.h12,
                              ),
                              child: CourseItem(
                                playlist: filteredCourses[index],
                              ),
                            );
                          },
                          childCount: filteredCourses.length,
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}