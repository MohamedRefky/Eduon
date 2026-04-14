import 'package:eduon/bloc/courses_bloc.dart';
import 'package:eduon/bloc/courses_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/screens/courses/courses_screen.dart';
import 'package:eduon/screens/courses_details/courses_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PopularCoursesSection extends StatelessWidget {
  const PopularCoursesSection({super.key, required this.playlist});
  final dynamic playlist;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        // Loading
        if (state.isPopularLoading) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.popularCourses.isEmpty) return const SizedBox();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Popular Courses',
                    style: TextTheme.of(context).displayLarge,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<CoursesBloc>(),
                            child: const CoursesScreen(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'View all',
                      style: TextTheme.of(context).displayMedium?.copyWith(
                        fontSize: AppSizes.sp14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Gap(AppSizes.h12),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (context, index) {
                  final playlist = state.popularCourses[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CoursesDetailsScreen(
                            playlistId: playlist.playlistId,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: AppSizes.h80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSizes.r12),
                            child: Image.network(
                              playlist.thumbnailUrl,
                              height: AppSizes.h80,
                              width: AppSizes.h120,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Gap(AppSizes.w10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  playlist.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextTheme.of(context).displayMedium,
                                ),
                                Gap(AppSizes.h6),
                                Text(
                                  playlist.channelTitle,
                                  style: TextTheme.of(context).displaySmall,
                                ),
                                Gap(AppSizes.h4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book,
                                      color: Color(0xFF334155),
                                      size: AppSizes.sp16,
                                    ),
                                    Gap(AppSizes.w4),
                                    Text(
                                      'Lessons ${playlist.videoCount}',
                                      style: TextTheme.of(context).displaySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
