import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

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
          Text(AppLocalizations.of(context)!.welcome_back, style: theme.textTheme.titleLarge),
          Gap(AppSizes.h8),
          Text(
            AppLocalizations.of(context)!.login_to_continue,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
