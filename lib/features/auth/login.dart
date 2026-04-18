import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SvgPicture.asset("assets/svg/logo_eduon.svg"),
          Text(
            "EDUON",
            style: TextTheme.of(
              context,
            ).titleLarge?.copyWith(fontSize: AppSizes.sp24),
          ),
        ],
      ),
    );
  }
}
