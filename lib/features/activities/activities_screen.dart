import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'constants/activities_constants.dart';
import 'widget/club_card.dart';
import 'package:eduon/l10n/app_localizations.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
            );
          },
        ),
        title: Text(l10n.students_activities),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSizes.h16),
        children: [
          Text(
            l10n.featured_clubs,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          Gap(AppSizes.h8),
          Text(
            l10n.featured_clubs_desc,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: AppSizes.sp18,
              height: 1.5,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          Gap(AppSizes.h16),
          ...ActivitiesConstants.getClubs(
            context,
          ).map((club) => ClubCardWidget(club: club)),
        ],
      ),
    );
  }
}
