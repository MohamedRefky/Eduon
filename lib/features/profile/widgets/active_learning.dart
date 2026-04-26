// lib/features/profile/widgets/active_learning.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/profile/cubit/profile_cubit.dart';
import 'package:eduon/features/profile/cubit/profile_state.dart';
import 'package:eduon/core/widgets/custom_snack_bar.dart';
import 'package:eduon/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class ActiveLearning extends StatefulWidget {
  const ActiveLearning({super.key});

  @override
  State<ActiveLearning> createState() => _ActiveLearningState();
}

class _ActiveLearningState extends State<ActiveLearning> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<ProfileCubit>().loadActiveCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (prev, curr) =>
          curr.snackBarMessage != null &&
          prev.snackBarMessage != curr.snackBarMessage &&
          !curr.isSaved,
      listener: (context, state) {
        if (state.snackBarMessage != null && state.snackBarType != null) {
          showCustomSnackBar(
            context,
            message: state.snackBarMessage!,
            type: state.snackBarType!,
          );
          context.read<ProfileCubit>().clearSnackBar();
        }
      },
      buildWhen: (prev, curr) =>
          prev.activeCourses != curr.activeCourses ||
          prev.isLoadingCourses != curr.isLoadingCourses,
      builder: (context, state) {
        if (!state.isLoadingCourses && state.activeCourses.isEmpty) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Active Learning',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Gap(AppSizes.h12),
            if (state.isLoadingCourses)
              Center(
                child: Lottie.asset(
                  height: AppSizes.h110,
                  'assets/gif/Trail_loading.json',
                  fit: BoxFit.contain,
                ),
              )
            else
              ...state.activeCourses.take(5).map((course) {
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.h12),
                  child: _buildCourseItem(context, course: course),
                );
              }),
          ],
        );
      },
    );
  }

  Widget _buildCourseItem(
    BuildContext context, {
    required Map<String, dynamic> course,
  }) {
    final progress = (course['progress'] ?? 0.0) as double;
    final watchedVideos = course['watchedVideos'] ?? 0;
    final totalVideos = course['totalVideos'] ?? 0;
    final title = course['title'] ?? 'Course';
    final thumbnailUrl = course['thumbnailUrl'] as String?;
    final playlistId = course['playlistId'] as String?;
    final percentage = (progress * 100).toInt();

    return Container(
      padding: EdgeInsets.all(AppSizes.h12),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r12),
            child: thumbnailUrl != null && thumbnailUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: thumbnailUrl,
                    width: AppSizes.w65,
                    height: AppSizes.h60,
                    fit: BoxFit.fill,
                    errorWidget: (context, error, stackTrace) {
                      return _buildDefaultIcon();
                    },
                  )
                : _buildDefaultIcon(),
          ),
          Gap(AppSizes.w10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: AppSizes.sp13),
                ),
                Gap(AppSizes.h4),
                Text(
                  '$watchedVideos/$totalVideos videos • $percentage% completed',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: AppSizes.sp12),
                ),
                Gap(AppSizes.h8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    color: Theme.of(context).colorScheme.primary,
                    minHeight: AppSizes.h6,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: AppSizes.sp18,
              color: Colors.grey[600],
            ),
            onPressed: () {
              if (playlistId != null) {
                context.read<ProfileCubit>().removeCourse(playlistId);
              }
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultIcon() {
    return Container(
      width: AppSizes.h56,
      height: AppSizes.h56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: Icon(Icons.school, color: Colors.white, size: AppSizes.sp24),
    );
  }
}