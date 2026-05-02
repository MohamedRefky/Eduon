import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduon/features/courses/bloc/courses_bloc.dart';
import 'package:eduon/features/courses/bloc/courses_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/courses_details/courses_details_screen.dart';
import 'package:eduon/features/home/widgets/popular_courses_skeleton.dart';
import 'package:eduon/core/theme/theme_extensions.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eduon/l10n/app_localizations.dart';

class PopularCoursesSection extends StatelessWidget {
  const PopularCoursesSection({super.key, required this.playlist});
  final dynamic playlist;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<CoursesBloc, CoursesState>(
      buildWhen: (prev, curr) =>
          prev.isPopularLoading != curr.isPopularLoading ||
          prev.isCategoriesLoading != curr.isCategoriesLoading ||
          prev.popularCourses != curr.popularCourses,
      builder: (context, state) {
        // Loading
        if (state.isPopularLoading || state.isCategoriesLoading) {
          return const PopularCoursesSkeleton();
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
                    l10n.popular_courses,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      final mainScreenState = context
                          .findAncestorStateOfType<MainScreenState>();
                      if (mainScreenState != null) {
                        mainScreenState.changeTab(1);
                      }
                    },
                    child: Text(
                      l10n.view_all,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
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
                itemCount: state.popularCourses.length > 5 ? 5 : state.popularCourses.length,
                itemBuilder: (context, index) {
                  final playlist = state.popularCourses[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseDetailsScreen(
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
                              child: CachedNetworkImage(
                                imageUrl: playlist.thumbnailUrl,
                                height: AppSizes.h90,
                                width: AppSizes.h120,
                                fit: BoxFit.fill,
                                placeholder: (context, url) {
                                  final shimmerTheme = Theme.of(
                                    context,
                                  ).extension<ShimmerTheme>()!;
                                  return Shimmer.fromColors(
                                    baseColor: shimmerTheme.baseColor,
                                    highlightColor: shimmerTheme.highlightColor,
                                    child: Container(
                                      height: AppSizes.h90,
                                      width: AppSizes.h120,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image_not_supported),
                                ),
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
                                        style: Theme.of(context).textTheme.displayMedium?.copyWith(height: 1.1),
                                      ),
                                      Gap(AppSizes.h4),
                                      Text(
                                        playlist.channelTitle,
                                        maxLines: 1,

                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.displaySmall,
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
                                              l10n.lessons_count(playlist.videoCount),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.displaySmall,
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
