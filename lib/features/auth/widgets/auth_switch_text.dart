import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AuthSwitchText extends StatelessWidget {
  const AuthSwitchText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.ontap,
  });
  final String firstText;
  final String secondText;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: GestureDetector(
        onTap: ontap,
        child: RichText(
          text: TextSpan(
            text: firstText,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: AppSizes.sp14,
            ),
            children: [
              TextSpan(
                text: secondText,
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: AppSizes.sp14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
