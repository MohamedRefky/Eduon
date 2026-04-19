import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'widgets/custom_year_container.dart';

class YearSelectionScreen extends StatefulWidget {
  const YearSelectionScreen({super.key});

  @override
  State<YearSelectionScreen> createState() => _YearSelectionScreenState();
}

class _YearSelectionScreenState extends State<YearSelectionScreen> {
  int? selectedIndex;

  // 📋 بيانات السنوات
  final List<Map<String, String>> years = const [
    {
      "title": "First Year",
      "description": "Freshman - Foundation courses & core basics",
      "icon": "assets/images/First_Year.png",
    },
    {
      "title": "Second Year",
      "description": "Sophomore - Intermediate concepts & electives",
      "icon": "assets/images/Second_Year.png",
    },
    {
      "title": "Third Year",
      "description": "Junior - Advanced majors & specialization",
      "icon": "assets/images/Third_Year.png",
    },
    {
      "title": "Fourth Year",
      "description": "Senior - Thesis, internship & graduation",
      "icon": "assets/images/Fourth_Year.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.w16,
            vertical: AppSizes.h24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Which year are you in?",
                style: textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF0F172A),
                ),
              ),
              Gap(AppSizes.h12),
              Text(
                "Select your current academic year to personalize your curriculum and study resources.",
                style: textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF64748B),
                  fontSize: AppSizes.sp16,
                  height: 1.4,
                ),
              ),
              Gap(AppSizes.h24),

              // ✨ القائمة بقت بسيطة جداً
              Expanded(
                child: ListView.separated(
                  itemCount: years.length,
                  separatorBuilder: (_, _) => SizedBox(height: AppSizes.h16),
                  itemBuilder: (context, index) {
                    return CustomYearContainer(
                      title: years[index]["title"]!,
                      description: years[index]["description"]!,
                      iconPath: years[index]["icon"]!,
                      isSelected: selectedIndex == index,
                      onSelect: () {
                        setState(() => selectedIndex = index);
                      },
                    );
                  },
                ),
              ),

              Gap(AppSizes.h16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.w24),
                child: ElevatedButton(
                  onPressed: selectedIndex == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainScreen(),
                            ),
                          );
                        },

                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
