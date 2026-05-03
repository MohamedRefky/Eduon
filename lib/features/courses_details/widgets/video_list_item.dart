import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/courses/data/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../cubit/course_details_cubit.dart';

class VideoListItem extends StatelessWidget {
  final VideoModel video;
  final int index;
  final bool isPlaying;
  final VoidCallback onTap;

  const VideoListItem({
    super.key,
    required this.video,
    required this.index,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseDetailsCubit>();

    return ListTile(
      onTap: onTap,
      tileColor: isPlaying ? Colors.deepPurple.withValues(alpha: 0.1) : null,
      leading: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl:
                  video.thumbnailUrl.isNotEmpty &&
                      video.thumbnailUrl.startsWith('http')
                  ? video.thumbnailUrl
                  : 'https://via.placeholder.com/150',

              width: AppSizes.w80,
              height: AppSizes.h60,
              fit: BoxFit.fill,

              placeholder: (context, url) => Container(
                color: Colors.grey.shade300,
                width: AppSizes.w80,
                height: AppSizes.h60,
              ),

              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade300,
                width: AppSizes.w80,
                height: AppSizes.h60,
                child: Icon(Icons.image_not_supported),
              ),
            ),
          ),
          if (isPlaying)
            Container(
              width: AppSizes.w80,
              height: AppSizes.h60,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: AppSizes.sp30,
              ),
            ),
        ],
      ),
      title: Text(
        video.title,
        maxLines: 3,
        style: TextTheme.of(context).displayMedium?.copyWith(
          fontSize: AppSizes.sp13,
          color: isPlaying ? Colors.deepPurple : TextTheme.of(context).displayMedium?.color,
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            '${index + 1}#',
            style: TextTheme.of(context).displaySmall?.copyWith(
              color: isPlaying ? Colors.deepPurple : Colors.grey.shade600,
            ),
          ),
          Gap(AppSizes.w8),
          Icon(
            Icons.remove_red_eye,
            size: AppSizes.sp14,
            color: Colors.grey.shade600,
          ),
          Gap(AppSizes.w4),
          Text(
            cubit.formatViewCount(video.viewCount),
            style: TextTheme.of(context).displaySmall?.copyWith(
              fontSize: AppSizes.sp12,
              color: Colors.grey.shade600,
            ),
          ),
          Gap(AppSizes.w8),

          Icon(
            Icons.access_time,
            size: AppSizes.sp14,
            color: Colors.grey.shade600,
          ),
          Gap(AppSizes.w4),
          Text(
            cubit.formatDuration(video.duration),
            style: TextTheme.of(context).displaySmall?.copyWith(
              fontSize: AppSizes.sp12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
