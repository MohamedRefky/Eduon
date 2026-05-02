import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/preferences_manager.dart';
import 'package:eduon/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:eduon/l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  void finishOnboarding() async {
    await PreferencesManager().setOnboardingSeen(true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, String>> onboardingData = [
      {
        "image": "assets/gif/onboarding1.json",
        "title": l10n.onboarding_title_1,
        "desc": l10n.onboarding_desc_1,
      },
      {
        "image": "assets/gif/onboarding2.json",
        "title": l10n.onboarding_title_2,
        "desc": l10n.onboarding_desc_2,
      },
      {
        "image": "assets/gif/onboarding3.json",
        "title": l10n.onboarding_title_3,
        "desc": l10n.onboarding_desc_3,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.w20),
          child: Column(
            children: [
              /// Skip Button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: finishOnboarding,
                  child: Text(
                    l10n.skip,
                    style: theme.textTheme.displayMedium?.copyWith(),
                  ),
                ),
              ),

              /// Pages
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == onboardingData.length - 1;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = onboardingData[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          item["image"]!,
                          width: AppSizes.h300,
                          height: AppSizes.h280,
                          fit: BoxFit.cover,
                        ),
                        Gap(AppSizes.h40),
                        Text(
                          item["title"]!,
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: AppSizes.sp24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gap(AppSizes.h16),
                        Text(
                          item["desc"]!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: AppSizes.sp18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Gap(AppSizes.h20),

              /// Indicator
              SmoothPageIndicator(
                controller: _controller,
                count: onboardingData.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Color(0xFF354155),
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
              Gap(AppSizes.h90),
              SizedBox(
                width: double.infinity,
                height: AppSizes.h50,
                child: ElevatedButton(
                  onPressed: () {
                    if (isLastPage) {
                      finishOnboarding();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(isLastPage ? l10n.get_started : l10n.next),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
