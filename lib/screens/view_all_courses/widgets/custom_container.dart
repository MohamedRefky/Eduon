import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.text, required this.svgPath, required this.containerColor, required this.onTap});
  final String text;
  final String svgPath;
  final Color containerColor ;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSizes.h130,
        width: AppSizes.w150,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(AppSizes.r27),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.20),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.h20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(svgPath, height: AppSizes.h28),
              SizedBox(height: AppSizes.h12),
              Text(
                text,
                style: TextStyle(
                  fontSize: AppSizes.sp16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
