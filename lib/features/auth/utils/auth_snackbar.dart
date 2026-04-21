import 'package:flutter/material.dart';
import 'package:eduon/core/constants/app_sizes.dart';

extension AuthSnackBar on BuildContext {
  void showAuthSnackBar(
    String message, {
    bool isError = false,
    int durationSeconds = 3,
  }) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(this).textTheme.labelMedium,
          ),
        ),
        backgroundColor: isError ? Colors.red.shade600 : null,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
        ),
        duration: Duration(seconds: durationSeconds),
      ),
    );
  }
}