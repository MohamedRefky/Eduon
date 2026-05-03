import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/constants/year_constant.dart';
import 'package:eduon/core/service/preferences_manager.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

import 'widgets/custom_year_container.dart';

class YearSelectionScreen extends StatelessWidget {
  YearSelectionScreen({super.key});
  final ValueNotifier<int?> selectedIndex = ValueNotifier(null);
  final uid = FirebaseAuth.instance.currentUser?.uid;
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
                      AppLocalizations.of(context)!.which_year,
                      style: textTheme.titleLarge,
                    ),

                    Gap(AppSizes.h12),

                    Text(
                      AppLocalizations.of(context)!.select_academic_year,
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: AppSizes.sp16,
                        height: 1.4,
                      ),
                    ),

                    Gap(AppSizes.h15),
                    ValueListenableBuilder<int?>(
                      valueListenable: selectedIndex,
                      builder: (context, selected, _) {
                        final l10n = AppLocalizations.of(context)!;
                        final translatedYears = [
                          {
                            "title": l10n.first_year,
                            "description": l10n.first_year_desc,
                            "icon": years[0]["icon"]!,
                          },
                          {
                            "title": l10n.second_year,
                            "description": l10n.second_year_desc,
                            "icon": years[1]["icon"]!,
                          },
                          {
                            "title": l10n.third_year,
                            "description": l10n.third_year_desc,
                            "icon": years[2]["icon"]!,
                          },
                          {
                            "title": l10n.fourth_year,
                            "description": l10n.fourth_year_desc,
                            "icon": years[3]["icon"]!,
                          },
                        ];
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: translatedYears.length,
                          separatorBuilder: (_, _) => Gap(AppSizes.h16),
                          itemBuilder: (context, index) {
                            return CustomYearContainer(
                              title: translatedYears[index]["title"]!,
                              description: translatedYears[index]["description"]!,
                              iconPath: translatedYears[index]["icon"]!,
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
                          await PreferencesManager().setUserSelectedYear(
                            uid!,
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
                  child: Text(AppLocalizations.of(context)!.continue_text),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
