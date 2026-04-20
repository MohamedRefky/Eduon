import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/auth/cubit/auth_cubit.dart';
import 'package:eduon/features/auth/screens/login_screen.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'widgets/active_learning.dart';
import 'widgets/avatar_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSizes.h16),
        children: [
          const AvatarSection(),
          Gap(AppSizes.h30),

          const ActiveLearning(),
          Gap(AppSizes.h24),

          _buildSettingsSection(context),
          Gap(AppSizes.h24),

          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    final List<Map<String, dynamic>> settings = [
      {'icon': Icons.language_outlined, 'title': 'Language'},
      {'icon': Icons.lock_outline, 'title': 'Privacy & Security'},
      {'icon': Icons.help_outline, 'title': 'About App'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF8A9BB0).withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppSizes.r15),
      ),
      child: Column(
        children: settings.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Column(
            children: [
              ListTile(
                leading: Icon(
                  item['icon'],
                  color: const Color(0xFF475569),
                  size: AppSizes.sp22,
                ),
                title: Text(
                  item['title'],
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: AppSizes.sp15,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              if (index < settings.length - 1)
                Divider(
                  height: 1,
                  color: Colors.grey.withValues(alpha: 0.2),
                  indent: AppSizes.w16,
                  endIndent: AppSizes.w16,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSizes.h56,
      decoration: BoxDecoration(
        color: const Color(0xFFFFCDD2).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppSizes.r15),
      ),
      child: TextButton.icon(
        onPressed: () async {
          await context.read<AuthCubit>().logout(); // ✅ await

          if (context.mounted) {
            // ✅ تأكد إن الـ context لسه شغال
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
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
