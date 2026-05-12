import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class CourseDetailsLoading extends StatelessWidget {
  const CourseDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            height: AppSizes.h110,
            'assets/gif/Trail_loading.json',
            fit: BoxFit.contain,
          ),
          Gap(AppSizes.h16),
          Text(
            AppLocalizations.of(context)!.loading_course,
            style: TextStyle(color: Colors.grey, fontSize: AppSizes.sp16),
          ),
        ],
      ),
    );
  }
}
