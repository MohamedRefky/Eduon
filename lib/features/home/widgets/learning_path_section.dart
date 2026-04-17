import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/constants/learning_paths_constants.dart';
import 'package:eduon/features/learning_path/learning_path_screen.dart';
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
                        builder: (_) =>
                            LearningPathScreen(learningPath: path),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: AppSizes.w240,
                    height: AppSizes.h200,
                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSizes.r15),
                              topRight: Radius.circular(AppSizes.r15),
                            ),
                            child: Image.asset(
                              path.image,
                              height: AppSizes.h110,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: AppSizes.h110,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.w10,
                                vertical: AppSizes.h6,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        path.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextTheme.of(
                                          context,
                                        ).displayMedium,
                                      ),
                                      Gap(AppSizes.h2),
                                      Text(
                                        path.description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextTheme.of(
                                          context,
                                        ).displaySmall,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.menu_book,
                                        color: const Color(0xFF334155),
                                        size: AppSizes.sp14,
                                      ),
                                      Gap(AppSizes.w4),
                                      Flexible(
                                        child: Text(
                                          '${path.totalCourses} Courses',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextTheme.of(context)
                                              .displaySmall
                                              ?.copyWith(
                                                fontSize: AppSizes.sp12,
                                              ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppSizes.w8,
                                          vertical: AppSizes.h4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF475569),
                                          borderRadius:
                                              BorderRadius.circular(
                                            AppSizes.r5,
                                          ),
                                        ),
                                        child: Text(
                                          'Start Now',
                                          style: TextTheme.of(context)
                                              .titleSmall
                                              ?.copyWith(
                                                fontSize: AppSizes.sp12,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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