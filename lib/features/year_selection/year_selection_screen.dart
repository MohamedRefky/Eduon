import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/constants/year_constant.dart';
import 'package:eduon/core/service/prefrances_maneger.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'widgets/custom_year_container.dart';

class YearSelectionScreen extends StatelessWidget {
  YearSelectionScreen({super.key});
  final ValueNotifier<int?> selectedIndex = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(AppSizes.h24),
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

                    Gap(AppSizes.h15),
                    ValueListenableBuilder<int?>(
                      valueListenable: selectedIndex,
                      builder: (context, selected, _) {
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: years.length,
                          separatorBuilder: (_, _) => Gap(AppSizes.h16),
                          itemBuilder: (context, index) {
                            return CustomYearContainer(
                              title: years[index]["title"]!,
                              description: years[index]["description"]!,
                              iconPath: years[index]["icon"]!,
                              isSelected: selected == index,
                              onSelect: () {
                                selectedIndex.value = index;
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Gap(AppSizes.h16),
            ValueListenableBuilder<int?>(
              valueListenable: selectedIndex,
              builder: (context, selected, _) {
                return ElevatedButton(
                  onPressed: selected == null
                      ? null
                      : () async {
                          await PrefrancesManeger().setSelectedYear(
                            years[selected]["title"]!,
                          );

                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MainScreen(),
                              ),
                            );
                          }
                        },
                  child: const Text("Continue"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
