import 'package:eduon/bloc/courses_bloc.dart';
import 'package:eduon/bloc/courses_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/models/playlist_model.dart';
import 'package:eduon/screens/course/course_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ViewAllCoursesScreen extends StatefulWidget {
  const ViewAllCoursesScreen({super.key});

  @override
  State<ViewAllCoursesScreen> createState() => _ViewAllCoursesScreenState();
}

class _ViewAllCoursesScreenState extends State<ViewAllCoursesScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Tech',
    'Business',
    'Design',
    'Soft Skills',
  ];

  List<PlaylistModel> _getFilteredCourses(CoursesState state) {
    // جيب كل الكورسات من الـ categories
    final allCourses = state.categories.expand((cat) => cat.playlists).toList();

    if (_selectedCategory == 'All') return allCourses;

    // فلتر على حسب الـ category المختارة
    return allCourses.where((p) => p.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        title: const Text(
          'All Courses',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          // Loading
          if (state.isCategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
            );
          }

          final filtered = _getFilteredCourses(state);

          return Column(
            children: [
              // ✅ Category Filter Tabs
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: AppSizes.h12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
                  child: Row(
                    children: _categories.map((cat) {
                      final isSelected = _selectedCategory == cat;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.only(right: AppSizes.w8),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.h16,
                            vertical: AppSizes.h8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF6C63FF)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey[700],
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // ✅ عدد الكورسات
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.h16,
                  vertical: AppSizes.h8,
                ),
                child: Row(
                  children: [
                    Text(
                      '${filtered.length} Courses',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ Courses List
              Expanded(
                child: filtered.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.school_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No courses found',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.all(AppSizes.h16),
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) => Gap(AppSizes.h12),
                        itemBuilder: (context, index) {
                          final playlist = filtered[index];
                          return _CourseItem(playlist: playlist);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ✅ Course Item Widget
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
                fit: BoxFit.fill,
              ),
            ),
            Gap(AppSizes.w10),

            // Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.h8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      playlist.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextTheme.of(context).displayMedium,
                    ),

                    Gap(AppSizes.h4),

                    // Channel
                    Text(
                      playlist.channelTitle,
                      style: TextTheme.of(context).displaySmall,
                    ),

                    Gap(AppSizes.h4),

                    // Category Badge + Lessons Count
                    Row(
                      children: [
                        // ✅ Category Badge
                        Container(
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
                            style: const TextStyle(
                              color: Color(0xFF6C63FF),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
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
                          style: TextTheme.of(context).displaySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Arrow
            Padding(
              padding: EdgeInsets.only(right: AppSizes.w8),
              child: const Icon(Icons.chevron_right, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
