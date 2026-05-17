// lib/features/profile/widgets/edit_profile_year_selector.dart

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/localization/l10n/app_localizations.dart';
import 'package:eduon/features/profile/cubit/profile_cubit.dart';
import 'package:eduon/features/profile/cubit/profile_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileYearSelector extends StatelessWidget {
  const EditProfileYearSelector({super.key});

  String _getYearKey(String? year) {
    if (year == null) {
      return 'none';
    }
    if (year.contains('1') ||
        year.contains('First') ||
        year.contains('الأولى')) {
      return 'year1';
    }
    if (year.contains('2') ||
        year.contains('Second') ||
        year.contains('الثانية')) {
      return 'year2';
    }
    if (year.contains('3') ||
        year.contains('Third') ||
        year.contains('الثالثة')) {
      return 'year3';
    }
    if (year.contains('4') ||
        year.contains('Fourth') ||
        year.contains('الرابعة')) {
      return 'year4';
    }
    return 'none';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final years = [
      l10n.first_year,
      l10n.second_year,
      l10n.third_year,
      l10n.fourth_year,
    ];

    final colorScheme = Theme.of(context).colorScheme;
    final cardColor = Theme.of(context).cardColor;

    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (prev, curr) => prev.selectedYear != curr.selectedYear,
      builder: (context, state) {
        return MenuAnchor(
          style: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(cardColor),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
            ),
          ),
          alignmentOffset: const Offset(0, 8),
          builder: (context, controller, child) {
            return GestureDetector(
              onTap: () {
                controller.isOpen ? controller.close() : controller.open();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w16,
                  vertical: AppSizes.h16,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xFFF8FAFC)
                      : colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.3,
                        ),
                  borderRadius: BorderRadius.circular(AppSizes.r15),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.academic_year(_getYearKey(state.selectedYear)),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Spacer(),
                    Icon(
                      controller.isOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
            );
          },
          menuChildren: years.map((e) {
            return SizedBox(
              width: MediaQuery.of(context).size.width - AppSizes.w40,
              child: MenuItemButton(
                onPressed: () {
                  context.read<ProfileCubit>().updateYear(e);
                },
                child: Text(
                  e,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
