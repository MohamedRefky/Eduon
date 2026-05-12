import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

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
            text: '${AppLocalizations.of(context)!.join} ',
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
          AppLocalizations.of(context)!.signup_to_start,
          style: theme.textTheme.labelSmall?.copyWith(fontSize: AppSizes.sp16),
        ),
        Gap(AppSizes.h20),
        Center(
          child: Text(
            AppLocalizations.of(context)!.login_to_continue,
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
