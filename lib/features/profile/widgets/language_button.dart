import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/localization/locale_cubit.dart';
import 'package:gap/gap.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        final isArabic = state.locale.languageCode == 'ar';
        return GestureDetector(
          onTap: () => context.read<LocaleCubit>().toggleLanguage(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.w16,
              vertical: AppSizes.h14,
            ),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.r15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: AppSizes.h42,
                  height: AppSizes.h42,
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSizes.r10),
                  ),
                  child: Icon(
                    Icons.language_rounded,
                    color: primary,
                    size: AppSizes.sp22,
                  ),
                ),
                Gap(AppSizes.w14),
                Expanded(
                  child: Text(
                    isArabic ? 'English' : 'العربية',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Icon(
                  isArabic
                      ? Icons.chevron_left_rounded
                      : Icons.chevron_right_rounded,
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
