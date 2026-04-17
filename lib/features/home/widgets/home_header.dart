import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

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
                    backgroundImage: AssetImage("assets/images/Avatar.png"),
                  ),
                  Gap(AppSizes.h10),
                  Text(
                    "Hello, \nTamer",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Spacer(),
                  Text('EDUON', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              Gap(AppSizes.h16),
              Text("Hi, Tamer!", style: TextTheme.of(context).titleLarge),
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
