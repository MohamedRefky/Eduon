import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class PopularCoursesSkeleton extends StatelessWidget {
  const PopularCoursesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final shimmerTheme = Theme.of(context).extension<ShimmerTheme>()!;
    final baseColor = shimmerTheme.baseColor;
    final highlightColor = shimmerTheme.highlightColor;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: AppSizes.w150,
                  height: AppSizes.h24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.r8),
                  ),
                ),
                const Spacer(),
                Container(
                  width: AppSizes.w50,
                  height: AppSizes.h24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.r8),
                  ),
                ),
              ],
            ),
            Gap(AppSizes.h12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Gap(AppSizes.h12),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                      side: const BorderSide(color: Colors.white, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: AppSizes.h90,
                          width: AppSizes.h120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppSizes.r12),
                          ),
                        ),
                        Gap(AppSizes.w8),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSizes.h6,
                              horizontal: AppSizes.h4,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: AppSizes.h14,
                                  width: double.infinity,
                                  color: Colors.white,
                                ),
                                Gap(AppSizes.h4),
                                Container(
                                  height: AppSizes.h14,
                                  width: AppSizes.w150,
                                  color: Colors.white,
                                ),
                                Gap(AppSizes.h12),
                                Container(
                                  height: AppSizes.h10,
                                  width: AppSizes.w100,
                                  color: Colors.white,
                                ),
                                Gap(AppSizes.h8),
                                Container(
                                  height: AppSizes.h10,
                                  width: AppSizes.w80,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(AppSizes.w4),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
