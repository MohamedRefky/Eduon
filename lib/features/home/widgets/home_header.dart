import 'dart:io';

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/preferences_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ValueListenableBuilder<int>(
      valueListenable: PreferencesManager().profileUpdateNotifier,
      builder: (context, _, _) {
        final uid = FirebaseAuth.instance.currentUser?.uid;
        final name = uid != null
            ? PreferencesManager().getUserFullName(uid)
            : null;
        final imagePath = uid != null
            ? PreferencesManager().getUserImage(uid)
            : null;

        final displayName = name ?? l10n.user;

        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppSizes.r30),
              bottomRight: Radius.circular(AppSizes.r30),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0F172A),
                Color(0xFFC0C7D2).withValues(alpha: 0.7),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: AppSizes.w16,
              right: AppSizes.w16,
              bottom: AppSizes.h16,
              top: AppSizes.h35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: AppSizes.r30,
                      backgroundImage:
                          imagePath != null && File(imagePath).existsSync()
                          ? FileImage(File(imagePath))
                          : const AssetImage("assets/images/Avatar.png")
                                as ImageProvider,
                    ),
                    Gap(AppSizes.w16),
                    Expanded(
                      child: Text(
                        "${l10n.hello}\n$displayName",
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'EDUON',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Gap(AppSizes.h10),
                Text(
                  "${l10n.hi} $displayName!",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(height: 1),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(AppSizes.h4),
                Text(
                  l10n.ready_to_learn,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(height: 1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
