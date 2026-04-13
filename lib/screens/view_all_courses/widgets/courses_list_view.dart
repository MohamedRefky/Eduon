import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/models/playlist_model.dart';
import 'package:eduon/screens/course/course_screen.dart';
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
          builder: (_) => CourseScreen(playlistId: playlist.playlistId),
        ),
      ),
      child: Container(
        height: AppSizes.h100,
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
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r12),
              child: Image.network(
                playlist.thumbnailUrl,
                height: AppSizes.h100,
                width: AppSizes.h120,
                fit: BoxFit.cover,
              ),
            ),
            Gap(AppSizes.w10),

            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.h8,
                  horizontal: AppSizes.w4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      playlist.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Gap(AppSizes.h4),

                    // Channel Name
                    Text(
                      playlist.channelTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Gap(AppSizes.h4),

                    // Category & Lessons Count
                    Row(
                      children: [
                        // Category Badge
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF6C63FF,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppSizes.r4),
                            ),
                            child: Text(
                              playlist.category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(
                                    color: const Color(0xFF587DBD),
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ),
                        const Spacer(),

                        // Lessons Count
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
              ),
            ),

            // Arrow Icon
            Padding(
              padding: EdgeInsets.only(right: AppSizes.w8),
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: AppSizes.sp24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
