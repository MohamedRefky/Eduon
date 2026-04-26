import 'dart:io';

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/preferences_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomHeader extends StatefulWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.h100);

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  String? _name;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    setState(() {
      _name = PreferencesManager().getUserFullName(uid);
      _imagePath = PreferencesManager().getUserImage(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.h8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0F172A).withValues(alpha: 0.9),
            const Color(0xFFC0C7D2),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSizes.r20),
          bottomRight: Radius.circular(AppSizes.r20),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: AppSizes.r27,
                backgroundImage:
                    _imagePath != null && File(_imagePath!).existsSync()
                    ? FileImage(File(_imagePath!))
                    : const AssetImage("assets/images/Avatar.png")
                          as ImageProvider,
              ),
              Gap(AppSizes.w10),
              Text(
                "Hello,\n${_name ?? 'User'}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              Text('EDUON', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
