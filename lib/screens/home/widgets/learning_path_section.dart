import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/constants/learning_paths_constants.dart';
import 'package:eduon/screens/learning_path/earning_path_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LearningPathSection extends StatelessWidget {
  const LearningPathSection({super.key});

  @override
  Widget build(BuildContext context) {
    final paths = LearningPathsConstants.learningPaths;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Learning Paths', style: TextTheme.of(context).displayLarge),
          Gap(AppSizes.h14),
          SizedBox(
            height: AppSizes.h200,
            child: ListView.separated(
              separatorBuilder: (context, index) => Gap(AppSizes.w16),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: paths.length,
              itemBuilder: (context, index) {
                final path = paths[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LearningPathScreen(learningPath: path),
                      ),
                    );
                  },
                  child: Container(
                    width: AppSizes.w250,
                    height: AppSizes.h220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSizes.r15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSizes.r15),
                            topRight: Radius.circular(AppSizes.r15),
                          ),
                          child: Image.asset(
                            path.image,
                            height: AppSizes.h120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(AppSizes.h4),
                        // Title
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.w10,
                            vertical: AppSizes.h4,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                path.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextTheme.of(context).displayMedium,
                              ),
                              Gap(AppSizes.h4),
                              // Description
                              Text(
                                path.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextTheme.of(context).displaySmall,
                              ),
                              Gap(AppSizes.h10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.menu_book,
                                    color: Color(0xFF64748B),
                                    size: AppSizes.sp16,
                                  ),
                                  Gap(AppSizes.w4),
                                  Text(
                                    '${path.totalCourses} Courses',
                                    style: TextTheme.of(context).displaySmall
                                        ?.copyWith(fontSize: AppSizes.sp13),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppSizes.w8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF475569),
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.r5,
                                      ),
                                    ),
                                    child: Text(
                                      'Start Learning',
                                      style: TextTheme.of(context).titleSmall
                                          ?.copyWith(fontSize: AppSizes.sp13),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
