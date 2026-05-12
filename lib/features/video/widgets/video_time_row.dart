import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class VideoTimeRow extends StatelessWidget {
  final String currentTime;
  final String totalTime;

  const VideoTimeRow({
    super.key,
    required this.currentTime,
    required this.totalTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
      child: Row(
        children: [
          Text(currentTime, style: TextTheme.of(context).labelSmall),
          const Spacer(),
          Text(totalTime, style: TextTheme.of(context).labelSmall),
        ],
      ),
    );
  }
}
