import 'dart:io';

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/preferences_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

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
    // Listen for profile updates
    PreferencesManager().profileUpdateNotifier.addListener(_loadUserData);
  }

  @override
  void dispose() {
    PreferencesManager().profileUpdateNotifier.removeListener(_loadUserData);
    super.dispose();
  }

  void _loadUserData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    if (mounted) {
      setState(() {
        _name = PreferencesManager().getUserFullName(uid);
        _imagePath = PreferencesManager().getUserImage(uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    ImageProvider imageProvider = const AssetImage("assets/images/Avatar.png");
    if (_imagePath != null && _imagePath!.isNotEmpty) {
      if (_imagePath!.startsWith('http')) {
        imageProvider = NetworkImage(_imagePath!);
      } else {
        final file = File(_imagePath!);
        if (file.existsSync()) {
          imageProvider = FileImage(file);
        }
      }
    }

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
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(AppSizes.r20),
          bottomEnd: Radius.circular(AppSizes.r20),
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
                backgroundImage: imageProvider,
              ),
              Gap(AppSizes.w10),
              Text(
                "${l10n.hello}\n${_name ?? l10n.user}",
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
