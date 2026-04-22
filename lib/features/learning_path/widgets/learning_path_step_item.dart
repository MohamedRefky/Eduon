import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LearningPathStepItem extends StatelessWidget {
  final int index;
  final String title;
  final String thumbnail;
  final int videoCount;
  final String channelTitle;
  final bool isLast;
  final VoidCallback onTap;

  const LearningPathStepItem({
    super.key,
    required this.index,
    required this.title,
    required this.thumbnail,
    required this.videoCount,
    required this.channelTitle,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: AppSizes.w36,
                height: AppSizes.h36,
                decoration: const BoxDecoration(
                  color: Color(0xFF354155),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextTheme.of(context).labelMedium,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: AppSizes.w2,
                    color: Color(0xFF305073),
                  ),
                ),
            ],
          ),
          Gap(AppSizes.w12),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.only(bottom: AppSizes.h16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: AppSizes.r4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (thumbnail.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.r12),
                          bottomLeft: Radius.circular(AppSizes.r12),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: thumbnail,
                          width: AppSizes.w100,
                          height: AppSizes.h80,
                          fit: BoxFit.fill,
                          errorWidget: (context, error, stackTrace) {
                            return Container(
                              width: AppSizes.w100,
                              height: AppSizes.h80,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported),
                            );
                          },
                          placeholder: (context, url) => Container(
                            width: AppSizes.w100,
                            height: AppSizes.h80,
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                    Gap(AppSizes.w8),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.h8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextTheme.of(context).displayMedium
                                  ?.copyWith(fontSize: AppSizes.sp13),
                            ),
                            Gap(AppSizes.h6),
                            Text(
                              channelTitle,
                              style: TextTheme.of(context).displaySmall,
                            ),
                            Gap(AppSizes.h6),
                            Row(
                              children: [
                                Icon(
                                  Icons.play_circle,
                                  size: AppSizes.sp14,
                                  color: Colors.grey,
                                ),
                                Gap(AppSizes.h6),
                                Text(
                                  '$videoCount Videos',
                                  style: TextTheme.of(context).displaySmall
                                      ?.copyWith(
                                        fontSize: AppSizes.sp12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppSizes.h8),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: AppSizes.sp16,
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
}
