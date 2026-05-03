import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/courses_details/courses_details_screen.dart';
import 'package:eduon/features/profile/cubit/profile_cubit.dart';
import 'package:eduon/features/profile/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ActiveLearning extends StatelessWidget {
  const ActiveLearning({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoadingCourses) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.activeCourses.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.active_learning,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Gap(AppSizes.h12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.activeCourses.length,
              separatorBuilder: (context, index) => Gap(AppSizes.h12),
              itemBuilder: (context, index) {
                final course = state.activeCourses[index];
                return _buildCourseItem(context, course: course);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCourseItem(
    BuildContext context, {
    required Map<String, dynamic> course,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<ProfileCubit>();

    final double progress = (course['progress'] ?? 0.0).toDouble();
    final int watchedVideos = (course['watchedVideos'] ?? 0);
    final int totalVideos = (course['totalVideos'] ?? 0);
    final String title = (course['title'] ?? l10n.courses).toString();
    final String? thumbnailUrl = course['thumbnailUrl'] as String?;
    final String? playlistId = course['playlistId'] as String?;
    final int percentage = (progress * 100).toInt();

    return Container(
      padding: EdgeInsets.all(AppSizes.h6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (playlistId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CourseDetailsScreen(playlistId: playlistId),
                  ),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r12),
              child: CachedNetworkImage(
                imageUrl: thumbnailUrl ?? '',
                width: AppSizes.h80,
                height: AppSizes.h80,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Container(
                  width: AppSizes.h80,
                  height: AppSizes.h80,
                  color: Colors.grey[300],
                  child: const Icon(Icons.play_circle_outline),
                ),
              ),
            ),
          ),
          Gap(AppSizes.w12),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Gap(AppSizes.h8),
                Text(
                  l10n.videos_completed(watchedVideos, totalVideos, percentage),
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: Colors.grey[600]),
                ),
                Gap(AppSizes.h8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: AppSizes.h6,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(AppSizes.w12),
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.delete_forever_outlined,
              color: Colors.red[400],
              size: AppSizes.sp20,
            ),
            onPressed: () {
              if (playlistId != null) {
                cubit.removeCourse(playlistId);
              }
            },
          ),
        ],
      ),
    );
  }
}
