import 'package:eduon/features/courses/bloc/courses_bloc.dart';
import 'package:eduon/features/courses/bloc/courses_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'widgets/category_filter_grid.dart';
import 'widgets/courses_count_header.dart';
import 'widgets/courses_list_view.dart';
import 'widgets/header_section.dart';
import 'widgets/search_field_widget.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String _selectedCategory = 'All';

  void _onCategoryTap(String category) {
    setState(() {
      _selectedCategory = _selectedCategory == category ? 'All' : category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const CustomHeader(),
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          if (state.isCategoriesLoading) {
            return Center(
              child: Lottie.asset(
                height: AppSizes.h110,
                'assets/gif/Trail_loading.json',
                fit: BoxFit.contain,
              ),
            );
          }
          final sourceCourses = state.searchQuery.isNotEmpty
              ? state.filteredPlaylists
              : state.allPlaylists;
          final filteredCourses = _selectedCategory == 'All'
              ? sourceCourses
              : sourceCourses
                    .where((p) => p.category == _selectedCategory)
                    .toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AppSizes.h16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderSection(),
                      Gap(AppSizes.h16),
                      const SearchFieldWidget(),
                      Gap(AppSizes.h16),
                      CategoryFilterGrid(
                        selectedCategory: _selectedCategory,
                        onCategoryTap: _onCategoryTap,
                      ),
                      Gap(AppSizes.h8),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: CoursesCountHeader(
                  count: filteredCourses.length,
                  selectedCategory: _selectedCategory,
                  onClear: () => setState(() => _selectedCategory = 'All'),
                ),
              ),
              if (filteredCourses.isEmpty && state.searchQuery.isNotEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Theme.of(context).disabledColor,
                        ),
                        const Gap(16),
                        Text(
                          l10n.no_results,
                          style: TextStyle(color: Theme.of(context).disabledColor),
                        ),
                      ],
                    ),
                  ),
                )
              else if (filteredCourses.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 64,
                          color: Theme.of(context).disabledColor,
                        ),
                        const Gap(16),
                        Text(
                          l10n.no_courses,
                          style: TextStyle(color: Theme.of(context).disabledColor),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AppSizes.h16,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: EdgeInsetsDirectional.only(
                          bottom: index == filteredCourses.length - 1
                              ? AppSizes.h16
                              : AppSizes.h12,
                        ),
                        child: CourseItem(playlist: filteredCourses[index]),
                      );
                    }, childCount: filteredCourses.length),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
