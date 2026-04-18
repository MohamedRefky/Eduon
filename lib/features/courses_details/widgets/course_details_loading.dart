import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CourseDetailsLoading extends StatelessWidget {
  const CourseDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Gap(AppSizes.h16),
          Text(
            'Loading course...',
            style: TextStyle(color: Colors.grey, fontSize: AppSizes.sp16),
          ),
        ],
      ),
    );
  }
}
