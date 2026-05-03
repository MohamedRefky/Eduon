import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/profile/cubit/profile_cubit.dart';
import 'package:eduon/features/profile/cubit/profile_state.dart';
import 'package:eduon/features/profile/widgets/edit_profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key});

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
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            /// Avatar
            Center(
              child: Container(
                width: AppSizes.h120,
                height: AppSizes.h120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: (state.imagePath != null && state.imagePath!.isNotEmpty)
                      ? (state.imagePath!.startsWith('http')
                          ? Image.network(state.imagePath!, fit: BoxFit.cover)
                          : (state.displayImage != null && state.displayImage!.existsSync()
                              ? Image.file(state.displayImage!, fit: BoxFit.cover)
                              : Image.asset('assets/images/Avatar.png', fit: BoxFit.cover)))
                      : Image.asset('assets/images/Avatar.png', fit: BoxFit.cover),
                ),
              ),
            ),
            Gap(AppSizes.h16),

            /// Name
            Text(
              (state.name != null && state.name!.isNotEmpty)
                  ? state.name!
                  : l10n.user,
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(fontSize: AppSizes.sp24),
            ),
            Gap(AppSizes.h12),

            /// Year Chip
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w28,
                  vertical: AppSizes.h8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(AppSizes.r20),
                ),
                child: Text(
                  l10n.academic_year(_getYearKey(state.selectedYear)),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontSize: AppSizes.sp16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Gap(AppSizes.h16),

            // Edit Profile Button
            Container(
              width: AppSizes.w180,
              height: AppSizes.h50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F172A),
                    const Color(0xFF64748B).withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppSizes.r20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () async {
                    final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (_) => BlocProvider.value(
                        value: context.read<ProfileCubit>(),
                        child: const EditProfileDialog(),
                      ),
                    );

                    if (result == true) {
                      if (context.mounted) {
                        context.read<ProfileCubit>().loadProfile();
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.w20),
                    alignment: Alignment.center,
                    child: Text(
                      l10n.edit_profile,
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: const Color(0xFFE2F6FF),
                            fontSize: AppSizes.sp16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
