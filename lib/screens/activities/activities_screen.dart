import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/screens/activities/constants/activities_constants.dart';
import 'package:eduon/screens/activities/widget/club_card.dart';
import 'package:eduon/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
          child: Icon(Icons.arrow_back, size: AppSizes.sp24),
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
            ).titleMedium?.copyWith(color: Color(0xFF0F172A)),
          ),
          Gap(AppSizes.h8),
          Text(
            'Connect with like-minded students, lead initiatives, and build a vibrant university experience beyond the classroom.',
            style: TextTheme.of(context).labelMedium?.copyWith(
              fontSize: AppSizes.sp18,
              height: 1.5,
              color: Color(0xFF574C4C),
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
