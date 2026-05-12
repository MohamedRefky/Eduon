// lib/features/profile/profile_screen.dart

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:eduon/features/profile/cubit/profile_cubit.dart';
import 'package:eduon/features/profile/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'package:eduon/core/theme/themes_controller.dart';
import 'widgets/active_learning.dart';
import 'widgets/avatar_section.dart';
import 'package:eduon/features/reminders/widgets/reminders_button.dart';
import 'widgets/language_button.dart';
import 'widgets/logout_button.dart';
import 'package:eduon/core/widgets/custom_snack_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listenWhen: (prev, curr) => curr.snackBarMessage != null,
        listener: (context, state) {
          if (state.snackBarMessage != null) {
            showCustomSnackBar(
              context,
              message: state.snackBarMessage!,
              type: state.snackBarType ?? SnackBarType.info,
            );
            context.read<ProfileCubit>().clearSnackBar();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MainScreen()),
                  (route) => false,
                );
              },
            ),
            title: Text(l10n.my_profile),
            actions: [
              ValueListenableBuilder<ThemeMode>(
                valueListenable: ThemesController.themeNotifier,
                builder: (context, mode, child) {
                  final isDark = mode == ThemeMode.dark;
                  return IconButton(
                    icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                    onPressed: () {
                      ThemesController.toggleTheme();
                    },
                  );
                },
              ),
              Gap(AppSizes.w8),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.all(AppSizes.h16),
            children: [
              const AvatarSection(),
              Gap(AppSizes.h30),
              const ActiveLearning(),
              Gap(AppSizes.h12),
              const RemindersButton(),
              Gap(AppSizes.h12),
              const LanguageButton(),
              Gap(AppSizes.h12),
              const LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
