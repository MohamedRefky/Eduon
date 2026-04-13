import 'package:eduon/bloc/courses_bloc.dart';
import 'package:eduon/bloc/courses_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/models/playlist_model.dart';
import 'package:eduon/core/widgets/custom_app_bar.dart';
import 'package:eduon/screens/course/course_screen.dart';
import 'package:eduon/screens/view_all_courses/widgets/custom_container.dart';
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

  List<PlaylistModel> _getFilteredCourses(CoursesState state) {
    final allCourses = state.categories.expand((cat) => cat.playlists).toList();
    if (_selectedCategory == 'All') return allCourses;
    return allCourses.where((p) => p.category == _selectedCategory).toList();
  }

  void _onCategoryTap(String category) {
    setState(() {
      if (_selectedCategory == category) {
        _selectedCategory = 'All';
      } else {
        _selectedCategory = category;
      }
    });
  }

  // ✅ بناء Category واحدة مع animation بسيط
  Widget _buildAnimatedCategory(String name, String svgPath, Color color) {
    final isSelected = _selectedCategory == name;
    
    return AnimatedScale(
      scale: isSelected ? 1.05 : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: CustomContainer(
          text: name,
          svgPath: svgPath,
          containerColor: isSelected ? color : color.withOpacity(0.5),
          onTap: () => _onCategoryTap(name),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          if (state.isCategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
            );
          }
          final filtered = _getFilteredCourses(state);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LEVEL UP YOUR FUTURE',
                  style: TextTheme.of(context).displayMedium?.copyWith(
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.5,
                      ),
                ),
                Gap(AppSizes.h8),
                Text(
                  'Explore\nCourses',
                  style: TextTheme.of(context).bodyLarge,
                ),
                Gap(AppSizes.h16),

                // Search Field
                TextFormField(
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  cursorColor: const Color(0xFF51565F),
                  style: TextTheme.of(context).displayMedium?.copyWith(
                        fontSize: AppSizes.sp16,
                        fontWeight: FontWeight.w500,
                      ),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search for courses',
                  ),
                ),
                Gap(AppSizes.h16),

                // ✅ Category Filter Grid
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildAnimatedCategory(
                          'Business',
                          'assets/svg/business.svg',
                          const Color(0xFFa8d7e8),
                        ),
                        _buildAnimatedCategory(
                          'Design',
                          'assets/svg/design.svg',
                          const Color(0xFFadbbcc),
                        ),
                      ],
                    ),
                    Gap(AppSizes.h12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildAnimatedCategory(
                          'Tech',
                          'assets/svg/tech.svg',
                          const Color(0xFFacc4cb),
                        ),
                        _buildAnimatedCategory(
                          'Soft Skills',
                          'assets/svg/soft_skills.svg',
                          const Color(0xFF7ab8de),
                        ),
                      ],
                    ),
                  ],
                ),

                Gap(AppSizes.h8),

                // عدد الكورسات + الـ category المختارة
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
                      const Spacer(),
                      if (_selectedCategory != 'All')
                        GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = 'All'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C63FF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _selectedCategory,
                                  style: const TextStyle(
                                    color: Color(0xFF6C63FF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Color(0xFF6C63FF),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Courses List
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
                          separatorBuilder: (_, __) => Gap(AppSizes.h12),
                          itemBuilder: (context, index) {
                            final playlist = filtered[index];
                            return _CourseItem(playlist: playlist);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Course Item Widget
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.h8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      playlist.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextTheme.of(context).displayMedium,
                    ),
                    Gap(AppSizes.h4),
                    Text(
                      playlist.channelTitle,
                      style: TextTheme.of(context).displaySmall,
                    ),
                    Gap(AppSizes.h4),
                    Row(
                      children: [
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