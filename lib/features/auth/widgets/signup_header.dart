import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Join  ',
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: AppSizes.sp24,
            ),

            children: [
              TextSpan(text: 'EDUON', style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
        Gap(AppSizes.h10),
        Text(
          'Enter your academic details to start your learning journey.',
          style: theme.textTheme.labelSmall?.copyWith(fontSize: AppSizes.sp16),
        ),
        Gap(AppSizes.h20),
        Center(
          child: Text(
            'Login to continue your\nlearning journey',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: AppSizes.sp15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
