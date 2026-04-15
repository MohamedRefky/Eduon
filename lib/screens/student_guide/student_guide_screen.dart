import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StudentGuideScreen extends StatelessWidget {
  const StudentGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, size: AppSizes.sp24),
        ),
        title: Text('Student Guide'),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSizes.h16),
        children: const [
          _GuideCard(
            year: 'Year 1 & 2',
            title: 'Freshman Guide',
            tips: [
              _GuideTip(
                title: 'Expand Your Network',
                description:
                    'Connect with students from all majors Your university network is your future\'s greatest asset.',
              ),
              _GuideTip(
                title: 'Master Your Time',
                description:
                    'Learn to balance study, life, and hobbies. Good habits now prevent burnout later.',
              ),
              _GuideTip(
                title: 'Focus on Soft Skills',
                description:
                    'Work on your communication Sharing your ideas clearly is the key to professional success.',
              ),
              _GuideTip(
                title: 'Explore & Discover',
                description:
                    'Don\'t limit yourself to your major, Join clubs, Events and explore new interests outside your field.',
              ),
            ],
          ),
          _GuideCard(
            year: 'Year 3 & 4',
            title: 'Senior Guide',
            tips: [
              _GuideTip(
                title: 'Go Professional',
                description:
                    'Start your LinkedIn profile. Connect with experts and observe how your industry operates.',
              ),
              _GuideTip(
                title: 'Stay Consistent',
                description:
                    'Small daily efforts beat sudden hard work Build a routine that helps you grow every day.',
              ),
              _GuideTip(
                title: 'Gain Experience',
                description:
                    'Seek any internship or volunteer work Learning "work culture" is as vital as the job itself.',
              ),
              _GuideTip(
                title: 'Solve Problems',
                description:
                    'Train your mind to find solutions, not just identify issues A proactive attitude wins everywhere.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final String year;
  final String title;
  final List<_GuideTip> tips;

  const _GuideCard({
    required this.year,
    required this.title,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.h20),
      padding: EdgeInsets.all(AppSizes.h20),
      decoration: BoxDecoration(
        color: const Color(0xFF6B7FA3),
        borderRadius: BorderRadius.circular(AppSizes.r20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            year,
            style: TextTheme.of(context).displayMedium?.copyWith(
              color: Colors.white,
              fontSize: AppSizes.sp16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(AppSizes.h4),
          Text(
            title,
            style: TextTheme.of(context).displayMedium?.copyWith(
              color: Colors.white,
              fontSize: AppSizes.sp16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(AppSizes.h12),
          ...tips.map((tip) => _TipItem(tip: tip)),
        ],
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final _GuideTip tip;

  const _TipItem({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextTheme.of(context).displayMedium?.copyWith(
              color: Colors.white,
              fontSize: AppSizes.sp16,
            ),
          ),
          Expanded(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: tip.title,
                    style: TextStyle(
                      color: const Color(0xFF90CAF9),
                      fontSize: AppSizes.sp14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  TextSpan(
                    text: ': ${tip.description}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppSizes.sp14,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideTip {
  final String title;
  final String description;

  const _GuideTip({required this.title, required this.description});
}
