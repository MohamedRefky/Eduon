import 'package:eduon/features/courses/bloc/courses_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/learning_path/data/models/learning_path_model.dart';
import 'package:eduon/features/courses_details/courses_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:eduon/l10n/app_localizations.dart';

import 'learning_path_step_item.dart';

class LearningPathRoadmapSection extends StatelessWidget {
  final LearningPathModel learningPath;
  final CoursesState state;

  const LearningPathRoadmapSection({
    super.key,
    required this.learningPath,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: learningPath.playlistIds.length,
              itemBuilder: (context, index) {
                final playlistId = learningPath.playlistIds[index];

                final playlist = state.categories
                    .expand((category) => category.playlists)
                    .where((playlist) => playlist.playlistId == playlistId);

                final currentPlaylist = playlist.isNotEmpty
                    ? playlist.first
                    : null;

                return LearningPathStepItem(
                  index: index,
                  title: currentPlaylist?.title ?? l10n.loading,
                  thumbnail: currentPlaylist?.thumbnailUrl ?? '',
                  videoCount: currentPlaylist?.videoCount ?? 0,
                  channelTitle: currentPlaylist?.channelTitle ?? '',
                  isLast: index == learningPath.playlistIds.length - 1,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CourseDetailsScreen(playlistId: playlistId),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSizes.h16),
            child: ElevatedButton.icon(
              onPressed: learningPath.playlistIds.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseDetailsScreen(
                            playlistId: learningPath.playlistIds.first,
                          ),
                        ),
                      );
                    },
              icon: Icon(Icons.play_arrow, size: AppSizes.sp24),
              label: Text(l10n.start_now),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
