import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Image.asset('assets/images/Avatar.png', fit: BoxFit.cover),
          ),
        ),
        Gap(AppSizes.h16),

        // Name
        Text(
          'Tamer Nabil',
          style: TextTheme.of(
            context,
          ).displayLarge?.copyWith(fontSize: AppSizes.sp24),
        ),
        Gap(AppSizes.h12),

        // Year Badge
        Container(
          width: AppSizes.w215,
          height: AppSizes.h38,
          decoration: BoxDecoration(
            color: const Color(0xFF8A9BB0),
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          child: Center(
            child: Text(
              'Second Year Student',
              style: TextTheme.of(context).displaySmall?.copyWith(
                color: Colors.white,
                fontSize: AppSizes.sp13,
              ),
            ),
          ),
        ),
        Gap(AppSizes.h16),

        // Edit Profile Button
        Container(
          width: AppSizes.w130,
          height: AppSizes.h48,
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
            child: InkWell(
              onTap: () {
                // Your action
              },
              borderRadius: BorderRadius.circular(AppSizes.r20),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Edit Profile',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
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
  }
}