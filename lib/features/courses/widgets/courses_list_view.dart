import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/models/playlist_model.dart';
import 'package:eduon/features/courses_details/courses_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CourseItem extends StatelessWidget {
  final PlaylistModel playlist;

  const CourseItem({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
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
          color: Colors.white,
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
              child: Image.network(
                playlist.thumbnailUrl,
                height: AppSizes.h180,
                width: double.infinity,
                fit: BoxFit.cover,
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
                      color: const Color(0xFF003346),
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

                                color: const Color(0xFF346178),
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
                            color: const Color(0xFF99ecfe),
                            borderRadius: BorderRadius.circular(AppSizes.r8),
                          ),
                          child: Text(
                            playlist.category.toUpperCase(),
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  color: const Color(0xFF005C52),
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
                            color: const Color(0xFF334155),
                            size: AppSizes.sp16,
                          ),
                          Gap(AppSizes.w4),
                          Text(
                            '${playlist.videoCount} lessons',
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
                          color: Color(0xFF2D3854),
                          borderRadius: BorderRadius.circular(AppSizes.r12),
                        ),
                        child: Center(
                          child: Text(
                            'Start ',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
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
