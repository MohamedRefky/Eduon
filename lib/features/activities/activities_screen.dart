import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'constants/activities_constants.dart';
import 'widget/club_card.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
            );
          },
          child: Icon(Icons.arrow_back),
        ),
        title: const Text('Students Activities'),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSizes.h16),
        children: [
          Text(
            'Featured Clubs',
            style: TextTheme.of(
              context,
            ).titleMedium?.copyWith(color: Theme.of(context).textTheme.titleLarge?.color),
          ),
          Gap(AppSizes.h8),
          Text(
            'Connect with like-minded students, lead initiatives, and build a vibrant university experience beyond the classroom.',
            style: TextTheme.of(context).labelMedium?.copyWith(
              fontSize: AppSizes.sp18,
              height: 1.5,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          Gap(AppSizes.h16),
          ...ActivitiesConstants.clubs.map(
            (club) => ClubCardWidget(club: club),
          ),
        ],
      ),
    );
  }
}
