import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/models/playlist_model.dart';
import 'package:eduon/screens/course/course_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CoursesListView extends StatelessWidget {
  final List<PlaylistModel> courses;

  const CoursesListView({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No courses found', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(AppSizes.h16),
      itemCount: courses.length,
      separatorBuilder: (_, _) => Gap(AppSizes.h12),
      itemBuilder: (context, index) {
        return _CourseItem(playlist: courses[index]);
      },
    );
  }
}

// ====================== Course Item Widget ======================
class _CourseItem extends StatelessWidget {
  final PlaylistModel playlist;

  const _CourseItem({required this.playlist});

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
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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

            // Content - ✅ استخدم Expanded بدل Padding
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.h8,
                  horizontal: AppSizes.w4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // ✅ مهم جداً
                  children: [
                    // Title
                    Text(
                      playlist.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextTheme.of(context).displayMedium,
                    ),
                    const SizedBox(height: 4), // ✅ استخدم SizedBox بدل Gap
                    // Channel Name
                    Text(
                      playlist.channelTitle,
                      maxLines: 1, // ✅ حدد عدد الأسطر
                      overflow: TextOverflow.ellipsis,
                      style: TextTheme.of(context).displaySmall,
                    ),
                    const SizedBox(height: 4),

                    // Category & Lessons Count
                    Row(
                      children: [
                        // Category Badge
                        Flexible(
                          // ✅ استخدم Flexible بدل Container عادي
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C63FF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              playlist.category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF6C63FF),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
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
                        const SizedBox(width: 4),
                        Text(
                          '${playlist.videoCount} lessons',
                          style: TextTheme.of(context).displaySmall,
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
              child: const Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
