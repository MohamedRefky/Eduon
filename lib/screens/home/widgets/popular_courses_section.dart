import 'package:eduon/bloc/courses_bloc.dart';
import 'package:eduon/bloc/courses_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/screens/course/course_screen.dart';
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
              Text(
                'Popular Courses',
                style: TextTheme.of(context).displayLarge,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Gap(AppSizes.h12),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: state.popularCourses.length,
                itemBuilder: (context, index) {
                  final playlist = state.popularCourses[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CourseScreen(playlistId: playlist.playlistId),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(AppSizes.h12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              playlist.thumbnailUrl,
                              height: 120,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            playlist.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            playlist.channelTitle,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
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
