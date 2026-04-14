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
                  const Spacer(),
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

                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.r12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(AppSizes.r12),
                              child: Image.network(
                                playlist.thumbnailUrl,
                                height: AppSizes.h90,
                                width: AppSizes.h120,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: AppSizes.h90,
                                    width: AppSizes.h120,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Gap(AppSizes.w8),

                            Expanded(
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: AppSizes.h6,
                                    horizontal: AppSizes.h4,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,

                                    children: [
                                      Text(
                                        playlist.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextTheme.of(
                                          context,
                                        ).displayMedium?.copyWith(height: 1.1),
                                      ),
                                      Gap(AppSizes.h4),
                                      Text(
                                        playlist.channelTitle,
                                        maxLines: 1,

                                        overflow: TextOverflow.ellipsis,
                                        style: TextTheme.of(
                                          context,
                                        ).displaySmall,
                                      ),
                                      Gap(AppSizes.h4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.menu_book,
                                            color: const Color(0xFF334155),
                                            size: AppSizes.sp14,
                                          ),
                                          Gap(AppSizes.w2),
                                          Flexible(
                                            child: Text(
                                              'Lessons ${playlist.videoCount}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextTheme.of(
                                                context,
                                              ).displaySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Gap(AppSizes.w4),
                          ],
                        ),
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
