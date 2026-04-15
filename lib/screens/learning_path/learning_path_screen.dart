import 'package:eduon/bloc/courses_bloc.dart';
import 'package:eduon/bloc/courses_event.dart';
import 'package:eduon/bloc/courses_state.dart';
import 'package:eduon/core/models/learning_path_model.dart';
import 'package:eduon/repository/course_repository.dart';
import 'package:eduon/screens/courses_details/courses_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningPathScreen extends StatelessWidget {
  final LearningPathModel learningPath;

  const LearningPathScreen({super.key, required this.learningPath});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CoursesBloc(repository: CourseRepository())
            ..add(GetAllCategoriesEvent()),
      child: LearningPathView(learningPath: learningPath),
    );
  }
}

class LearningPathView extends StatelessWidget {
  final LearningPathModel learningPath;

  const LearningPathView({super.key, required this.learningPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(learningPath.title)),
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          return Column(
            children: [
              // Header
              _buildHeader(),

              const Divider(),

              // Courses List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: learningPath.playlistIds.length,
                  itemBuilder: (context, index) {
                    final playlistId = learningPath.playlistIds[index];

                    // ابحث عن الـ Playlist في الـ State
                    final playlist = state.categories
                        .expand((cat) => cat.playlists)
                        .where((p) => p.playlistId == playlistId)
                        .firstOrNull;

                    return _buildCourseStep(
                      context: context,
                      index: index,
                      playlistId: playlistId,
                      title: playlist?.title ?? 'Loading...',
                      thumbnail: playlist?.thumbnailUrl ?? '',
                      videoCount: playlist?.videoCount ?? 0,
                      channelTitle: playlist?.channelTitle ?? '',
                      isLast: index == learningPath.playlistIds.length - 1,
                    );
                  },
                ),
              ),

              // Start Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CoursesDetailsScreen(
                          playlistId: learningPath.playlistIds.first,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('ابدأ من الأول'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.deepPurple.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      learningPath.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      learningPath.description,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Level
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getLevelColor(learningPath.level),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  learningPath.level,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.book, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${learningPath.totalCourses} Courses',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseStep({
    required BuildContext context,
    required int index,
    required String playlistId,
    required String title,
    required String thumbnail,
    required int videoCount,
    required String channelTitle,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Indicator
          Column(
            children: [
              // Circle Number
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.deepPurple.withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 12),

          // Course Card
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CoursesDetailsScreen(playlistId: playlistId),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Thumbnail
                    if (thumbnail.isNotEmpty)
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: Image.network(
                          thumbnail,
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 80,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported),
                            );
                          },
                        ),
                      ),

                    const SizedBox(width: 12),

                    // Info
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              channelTitle,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.play_circle,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '$videoCount Videos',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Arrow
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
