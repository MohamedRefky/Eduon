import 'package:eduon/features/courses/data/models/video_model.dart';
import 'package:flutter/material.dart';

import 'video_list_item.dart';

class VideoListSection extends StatelessWidget {
  final List<VideoModel> videos;
  final int currentIndex;
  final Function(int) onVideoSelected;

  const VideoListSection({
    super.key,
    required this.videos,
    required this.currentIndex,
    required this.onVideoSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return VideoListItem(
            video: videos[index],
            index: index,
            isPlaying: index == currentIndex,
            onTap: () => onVideoSelected(index),
          );
        },
      ),
    );
  }
}