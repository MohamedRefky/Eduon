import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSizes.h8),
        Text(
          'LEVEL UP YOUR FUTURE',
          style: TextTheme.of(context).displayMedium?.copyWith(
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w500,
            letterSpacing: -1.5,
          ),
        ),
        Gap(AppSizes.h8),
        Text('Explore\nCourses', style: TextTheme.of(context).bodyLarge),
      ],
    );
  }
}
