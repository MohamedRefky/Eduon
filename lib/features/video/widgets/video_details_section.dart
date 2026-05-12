import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class VideoDetailsSection extends StatelessWidget {
  final String title;
  final String playlistTitle;

  const VideoDetailsSection({
    super.key,
    required this.title,
    required this.playlistTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: TextTheme.of(
                context,
              ).labelSmall?.copyWith(fontSize: AppSizes.sp18),
            ),
          if (title.isNotEmpty) Gap(AppSizes.h8),
          Text(playlistTitle, style: TextTheme.of(context).labelSmall),
        ],
      ),
    );
  }
}
