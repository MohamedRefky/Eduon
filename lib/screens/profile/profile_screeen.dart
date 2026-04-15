import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
          _buildAvatarSection(context),
          Gap(AppSizes.h30),

          // Active Learning Section
          _buildActiveLearning(context),
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

  Widget _buildAvatarSection(BuildContext context) {
    return Column(
      children: [
        // Avatar
        Container(
          width: AppSizes.h120,
          height: AppSizes.h120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/Avatar.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.person,
                  size: AppSizes.sp34,
                  color: Colors.grey,
                );
              },
            ),
          ),
        ),
        Gap(AppSizes.h16),

        // Name
        Text(
          'Tamer Nabil',
          style: TextTheme.of(context).displayLarge?.copyWith(
            fontSize: AppSizes.sp24,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gap(AppSizes.h12),

        // Year Badge
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.w40,
            vertical: AppSizes.h8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF8A9BB0),
            borderRadius: BorderRadius.circular(AppSizes.r30),
          ),
          child: Text(
            'Second Year Student',
            style: TextTheme.of(context).displaySmall?.copyWith(
              color: Colors.white,
              fontSize: AppSizes.sp13,
            ),
          ),
        ),
        Gap(AppSizes.h16),

        // Edit Profile Button
        SizedBox(
          width: double.infinity,
          height: AppSizes.h48,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D3A4A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.r30),
              ),
            ),
            child: Text(
              'Edit Profile',
              style: TextTheme.of(context).displayMedium?.copyWith(
                color: Colors.white,
                fontSize: AppSizes.sp16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveLearning(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Active Learning', style: TextTheme.of(context).displayLarge),
            const Spacer(),
            Icon(Icons.more_horiz, size: AppSizes.sp24, color: Colors.grey),
          ],
        ),
        Gap(AppSizes.h12),

        // Course 1
        _buildCourseItem(
          context,
          title: 'Advanced Prototyping Workshop',
          subtitle: '2 hours left • Design Lab',
          progress: 0.75,
          color: const Color(0xFFF5C5A3),
          icon: Icons.design_services,
        ),
        Gap(AppSizes.h12),

        // Course 2
        _buildCourseItem(
          context,
          title: 'Human-Computer Interaction',
          subtitle: 'Due Tomorrow • Assignment 4',
          progress: 0.25,
          color: Colors.white,
          icon: Icons.people_outline,
        ),
      ],
    );
  }

  Widget _buildCourseItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required double progress,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(AppSizes.h12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.h56,
            height: AppSizes.h56,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppSizes.r12),
            ),
            child: Icon(icon, color: Colors.white, size: AppSizes.sp24),
          ),
          Gap(AppSizes.w10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextTheme.of(
                    context,
                  ).displayMedium?.copyWith(fontSize: AppSizes.sp13),
                ),
                Gap(AppSizes.h4),
                Text(
                  subtitle,
                  style: TextTheme.of(
                    context,
                  ).displaySmall?.copyWith(fontSize: AppSizes.sp12),
                ),
                Gap(AppSizes.h8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    color: const Color(0xFF3B82F6),
                    minHeight: AppSizes.h6,
                  ),
                ),
              ],
            ),
          ),
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
