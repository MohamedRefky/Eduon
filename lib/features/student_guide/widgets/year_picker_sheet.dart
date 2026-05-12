import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eduon/core/widgets/custom_snack_bar.dart';
import 'package:gap/gap.dart';
import '../cubit/student_guide_cubit.dart';

class YearPickerSheet extends StatelessWidget {
  const YearPickerSheet({
    super.key,
    required this.currentYear,
    required this.parentContext,
  });

  final String currentYear;
  final BuildContext parentContext;

  static void show(BuildContext context, String currentYear) {
    final cubit = context.read<StudentGuideCubit>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: YearPickerSheet(currentYear: currentYear, parentContext: context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<StudentGuideCubit>();

    final years = [
      ('First Year', l10n.first_year),
      ('Second Year', l10n.second_year),
      ('Third Year', l10n.third_year),
      ('Fourth Year', l10n.fourth_year),
    ];

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(AppSizes.h16),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: AppSizes.w20),
            child: Text(
              l10n.select_year,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gap(AppSizes.h8),
          ...years.map((entry) {
            final isSelected = currentYear == entry.$1;
            return ListTile(
              contentPadding: EdgeInsetsDirectional.symmetric(
                horizontal: AppSizes.w20,
                vertical: 0,
              ),
              leading: Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: isSelected ? colorScheme.primary : Colors.grey,
                size: AppSizes.sp20,
              ),
              title: Text(
                entry.$2,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? colorScheme.primary : null,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                cubit.changeYear(entry.$1);
                showCustomSnackBar(
                  parentContext,
                  message: l10n.year_changed,
                  type: SnackBarType.success,
                );
              },
            );
          }),
          Gap(AppSizes.h8),
        ],
      ),
    );
  }
}
