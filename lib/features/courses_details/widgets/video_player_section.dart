import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../cubit/course_details_state.dart';
import 'player_overlay_controls.dart';

class VideoPlayerSection extends StatelessWidget {
  final Widget player;
  final CourseDetailsState state;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const VideoPlayerSection({
    super.key,
    required this.player,
    required this.state,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    if (!state.hasVideos) {
      return SizedBox(
        height: AppSizes.h220,
        child: Center(
          child: Lottie.asset(
            height: AppSizes.h110,
            'assets/gif/Trail_loading.json',
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    return Stack(
      children: [
        player,
        PlayerOverlayControls(
          canPlayPrevious: state.canPlayPrevious,
          canPlayNext: state.canPlayNext,
          currentTitle: state.currentVideo?.title ?? '',
          onPrevious: onPrevious,
          onNext: onNext,
        ),
      ],
    );
  }
}
