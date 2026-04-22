import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/prefrances_maneger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'edit_profile_dialog.dart';

class AvatarSection extends StatefulWidget {
  const AvatarSection({super.key});

  @override
  State<AvatarSection> createState() => _AvatarSectionState();
}

class _AvatarSectionState extends State<AvatarSection> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final selectedYear = PrefrancesManeger().getUserSelectedYear(
      FirebaseAuth.instance.currentUser!.uid,
    );
    final name = uid != null ? PrefrancesManeger().getUserFullName(uid) : null;
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
          name ?? 'Tamer Nabil',
          style: TextTheme.of(
            context,
          ).displayLarge?.copyWith(fontSize: AppSizes.sp24),
        ),
        Gap(AppSizes.h12),

        // Year Badge
        IntrinsicWidth(
          child: Container(
            height: AppSizes.h38,
            padding: EdgeInsets.symmetric(horizontal: AppSizes.w48),
            decoration: BoxDecoration(
              color: const Color(0xFF8A9BB0),
              borderRadius: BorderRadius.circular(AppSizes.r12),
            ),
            child: Center(
              child: Text(
                selectedYear ?? 'No year selected',
                style: TextTheme.of(context).displaySmall?.copyWith(
                  color: Colors.white,
                  fontSize: AppSizes.sp14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        Gap(AppSizes.h16),

        // Edit Profile Button
        Container(
          width: AppSizes.w130,
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
                  builder: (_) => const EditProfileDialog(),
                );

                if (result == true && mounted) {
                  setState(() {});
                }
              },
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
