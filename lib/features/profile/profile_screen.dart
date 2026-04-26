// lib/features/profile/profile_screen.dart

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/auth/cubit/auth_cubit.dart';
import 'package:eduon/features/auth/screens/login_screen.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:eduon/features/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'widgets/active_learning.dart';
import 'widgets/avatar_section.dart';
import 'package:eduon/core/theme/themes_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(),
      child: const _ProfileScreenBody(),
    );
  }
}

class _ProfileScreenBody extends StatelessWidget {
  const _ProfileScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('My Profile'),
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
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSizes.h16),
        children: [
          const AvatarSection(),
          Gap(AppSizes.h30),
          const ActiveLearning(),
          Gap(AppSizes.h24),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSizes.h56,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSizes.r15),
        border: Border.all(color: Colors.red.withValues(alpha: 0.5), width: 1.5),
      ),
      child: TextButton.icon(
        onPressed: () async {
          await context.read<AuthCubit>().logout();

          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false,
            );
          }
        },
        icon: Icon(Icons.logout, color: Colors.red, size: AppSizes.sp22),
        label: Text(
          'Logout',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.red,
                fontSize: AppSizes.sp16,
              ),
        ),
      ),
    );
  }
}