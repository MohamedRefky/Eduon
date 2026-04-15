import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'widgets/active_learning.dart';
import 'widgets/avatar_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
            );
          },
          child: Icon(Icons.arrow_back, size: AppSizes.sp24),
        ),
        title: const Text('My Profile'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.w16),
            child: Icon(Icons.settings_outlined, size: AppSizes.sp24),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSizes.h16),
        children: [
          // Avatar Section
          AvatarSection(),
          Gap(AppSizes.h30),

          // Active Learning Section
          ActiveLearning(),
          Gap(AppSizes.h24),

          // Settings Section
          _buildSettingsSection(context),
          Gap(AppSizes.h24),

          // Logout Button
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
        color: const Color(0xFF8A9BB0).withValues(alpha: 0.3),
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
                  item['icon'] as IconData,
                  color: const Color(0xFF475569),
                  size: AppSizes.sp22,
                ),
                title: Text(
                  item['title'] as String,
                  style: TextTheme.of(context).displaySmall?.copyWith(
                    fontSize: AppSizes.sp15,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: AppSizes.sp22,
                ),
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
        onPressed: () {},
        icon: Icon(Icons.logout, color: Colors.red, size: AppSizes.sp22),
        label: Text(
          'Logout',
          style: TextTheme.of(
            context,
          ).displayMedium?.copyWith(color: Colors.red, fontSize: AppSizes.sp16),
        ),
      ),
    );
  }
}
