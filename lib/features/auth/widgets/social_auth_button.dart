import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
              child: Text(
                'OR CONTINUE WITH',
                style: TextTheme.of(
                  context,
                ).displaySmall?.copyWith(fontSize: AppSizes.sp10),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        Gap(AppSizes.h20),
        Container(
          height: AppSizes.h40,
          width: AppSizes.w100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/google.svg'),
              Gap(AppSizes.w4),
              Text("Google", style: TextTheme.of(context).bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
