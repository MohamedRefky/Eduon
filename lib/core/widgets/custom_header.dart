import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.h100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        height: AppSizes.h110,
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
      ),
      title: Padding(
        padding: EdgeInsets.only(top: AppSizes.h12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: AppSizes.r27,
              backgroundImage: const AssetImage("assets/images/Avatar.png"),
            ),
            Gap(AppSizes.h10),
            Text(
              "Hello,\nTamer",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            Text('EDUON', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
