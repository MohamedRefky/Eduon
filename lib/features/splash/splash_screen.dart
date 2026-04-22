import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/prefrances_maneger.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:eduon/features/onboarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _logoOffset = -1; // من الشمال
  double _textOffset = 1; // من اليمين
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _logoOffset = 0;
        _textOffset = 0;
        _opacity = 1;
      });
    });

    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = PrefrancesManeger();
    final seenOnboarding = prefs.getOnboardingSeen();
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (!mounted) return;

    if (!seenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } else if (uid != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A3446), Color(0xFF354155), Color(0xFF929AAB)],
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _opacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// LOGO من الشمال
                AnimatedSlide(
                  offset: Offset(_logoOffset, 0),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  child: SvgPicture.asset(
                    'assets/svg/logo_eduon.svg',
                    width: AppSizes.w75,
                  ),
                ),

                Gap(AppSizes.w10),

                /// TEXT من اليمين
                AnimatedSlide(
                  offset: Offset(_textOffset, 0),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  child: Text(
                    'EDUON',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: AppSizes.sp48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
