import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          Gap(AppSizes.h80),
          SvgPicture.asset('assets/svg/logo_eduon.svg', height: AppSizes.h60),
          Gap(AppSizes.h10),
          Text('EDUON', style: theme.textTheme.bodyMedium),
          Gap(AppSizes.h15),
          Text('Welcome Back', style: theme.textTheme.titleLarge),
          Gap(AppSizes.h8),
          Text(
            'Login to continue your learning journey',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
