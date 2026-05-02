import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/courses/data/models/playlist_model.dart';
import 'package:eduon/features/courses_details/courses_details_screen.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CourseItem extends StatelessWidget {
  final PlaylistModel playlist;

  const CourseItem({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String categoryDisplay = playlist.category;
    if (playlist.category == 'Design') {
      categoryDisplay = l10n.design;
    } else if (playlist.category == 'Tech') {
      categoryDisplay = l10n.tech;
    } else if (playlist.category == 'Soft Skills') {
      categoryDisplay = l10n.soft_skills;
    } else if (playlist.category == 'Video Editing') {
      categoryDisplay = l10n.video_editing;
    } else if (playlist.category == 'Business') {
      categoryDisplay = l10n.business;
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CourseDetailsScreen(playlistId: playlist.playlistId),
        ),
      ),
      child: Container(
        width: double.infinity,
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.r12),
                topRight: Radius.circular(AppSizes.r12),
              ),
              child: CachedNetworkImage(
                imageUrl: playlist.thumbnailUrl,
                height: AppSizes.h180,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade300,
                  height: AppSizes.h180,
                  width: double.infinity,
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade300,
                  height: AppSizes.h180,
                  width: double.infinity,
                ),
              ),
            ),
            Gap(AppSizes.w10),
            // Content
            Padding(
              padding: EdgeInsets.only(
                left: AppSizes.w10,
                right: AppSizes.w10,
                bottom: AppSizes.h10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    playlist.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  Gap(AppSizes.h4),
                  // Description
                  playlist.description.isEmpty
                      ? const SizedBox.shrink()
                      : Text(
                          playlist.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontSize: AppSizes.sp14,

                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                        ),

                  Gap(AppSizes.h8),
                  // Category & Lessons Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Category Badge
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppSizes.r8),
                          ),
                          child: Text(
                            categoryDisplay.toUpperCase(),
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),

                      // Lessons Count
                      Row(
                        children: [
                          Icon(
                            Icons.menu_book,
                            color: Theme.of(context).iconTheme.color,
                            size: AppSizes.sp16,
                          ),
                          Gap(AppSizes.w4),
                          Text(
                            l10n.lessons_count(playlist.videoCount),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(AppSizes.h8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Channel Name
                      Expanded(
                        child: Text(
                          playlist.channelTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Container(
                        height: AppSizes.h30,
                        width: AppSizes.w70,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(AppSizes.r12),
                        ),
                        child: Center(
                          child: Text(
                            l10n.start_now,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppSizes.sp12,
                                ),
                          ),
                        ),
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
  }
}
