import 'dart:io';

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/prefrances_maneger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
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
      _name = PrefrancesManeger().getUserFullName(uid);
      _imagePath = PrefrancesManeger().getUserImage(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: AppSizes.h260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppSizes.r30),
              bottomRight: Radius.circular(AppSizes.r30),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0F172A),
                Color(0xFFC0C7D2).withValues(alpha: 0.7),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(AppSizes.h20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(AppSizes.h20),
              Row(
                children: [
                  CircleAvatar(
                    radius: AppSizes.r30,
                    backgroundImage:
                        _imagePath != null && File(_imagePath!).existsSync()
                        ? FileImage(File(_imagePath!))
                        : const AssetImage("assets/images/Avatar.png")
                              as ImageProvider,
                  ),
                  Gap(AppSizes.h10),
                  Text(
                    "Hello,\n${_name ?? 'User'}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Spacer(),
                  Text('EDUON', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              Gap(AppSizes.h16),
              Text(
                "Hi, ${_name ?? 'User'}!",
                style: TextTheme.of(context).titleLarge,
              ),
              Gap(AppSizes.h8),
              Text(
                "Ready to turn \nlearning on?",
                style: TextTheme.of(context).titleLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
