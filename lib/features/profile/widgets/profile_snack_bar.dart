// lib/features/profile/widgets/profile_snack_bar.dart

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/profile/cubit/profile_state.dart';
import 'package:flutter/material.dart';

void showProfileSnackBar(
  BuildContext context, {
  required String message,
  required SnackBarType type,
}) {
  Color backgroundColor;
  switch (type) {
    case SnackBarType.success:
      backgroundColor = Colors.green.shade600;
      break;
    case SnackBarType.error:
      backgroundColor = Colors.red.shade600;
      break;
    case SnackBarType.info:
      backgroundColor = const Color(0xFF323232);
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.w16,
        vertical: AppSizes.h12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}