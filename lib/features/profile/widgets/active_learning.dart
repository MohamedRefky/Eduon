import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/video_progress_service.dart';
import 'package:eduon/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class ActiveLearning extends StatefulWidget {
  const ActiveLearning({super.key});

  @override
  State<ActiveLearning> createState() => _ActiveLearningState();
}

class _ActiveLearningState extends State<ActiveLearning> with RouteAware {
  final VideoProgressService _progressService = VideoProgressService();
  List<Map<String, dynamic>> _courses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    if (!mounted) return;

    if (_courses.isEmpty) {
      setState(() => _isLoading = true);
    }

    _courses = await _progressService.getActiveCourses();

    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  Future<void> _removeCourse(String playlistId) async {
    await _progressService.clearCourseProgress(playlistId);
    _loadCourses();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course removed'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading && _courses.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Learning',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Gap(AppSizes.h12),

        if (_isLoading)
          Center(
            child: Lottie.asset(
              height: AppSizes.h110,
              'assets/gif/Trail_loading.json',
              fit: BoxFit.contain,
            ),
          )
        else
          ..._courses.take(5).map((course) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppSizes.h12),
              child: _buildCourseItem(context, course: course),
            );
          }),
      ],
    );
  }

  Widget _buildCourseItem(
    BuildContext context, {
    required Map<String, dynamic> course,
  }) {
    final progress = (course['progress'] ?? 0.0) as double;
    final watchedVideos = course['watchedVideos'] ?? 0;
    final totalVideos = course['totalVideos'] ?? 0;
    final title = course['title'] ?? 'Course';
    final thumbnailUrl = course['thumbnailUrl'] as String?;
    final playlistId = course['playlistId'] as String?;
    final percentage = (progress * 100).toInt();

    return Container(
      padding: EdgeInsets.all(AppSizes.h12),
      decoration: BoxDecoration(
        color: Color(0xFFd2dae3),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r12),
            child: thumbnailUrl != null && thumbnailUrl.isNotEmpty
                ? Image.network(
                    thumbnailUrl,
                    width: AppSizes.h56,
                    height: AppSizes.h56,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildDefaultIcon();
                    },
                  )
                : _buildDefaultIcon(),
          ),
          Gap(AppSizes.w10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(fontSize: AppSizes.sp13),
                ),
                Gap(AppSizes.h4),
                Text(
                  '$watchedVideos/$totalVideos videos • $percentage% completed',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall?.copyWith(fontSize: AppSizes.sp12),
                ),
                Gap(AppSizes.h8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    color: const Color(0xFF3B82F6),
                    minHeight: AppSizes.h6,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: AppSizes.sp18,
              color: Colors.grey[400],
            ),
            onPressed: () {
              if (playlistId != null) {
                _removeCourse(playlistId);
              }
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultIcon() {
    return Container(
      width: AppSizes.h56,
      height: AppSizes.h56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: Icon(Icons.school, color: Colors.white, size: AppSizes.sp24),
    );
  }
}
