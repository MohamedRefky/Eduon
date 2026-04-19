import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/auth/widgets/auth_switch_text.dart';
import 'package:eduon/features/auth/widgets/custom_text_form_field.dart';
import 'package:eduon/features/auth/widgets/signup_header.dart';
import 'package:eduon/features/auth/widgets/social_auth_button.dart';
import 'package:eduon/features/year_selection/year_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _showPassword = false;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(AppSizes.h80),
              SignUpHeader(),
              Gap(AppSizes.h15),
              Text(
                'Full Name',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: AppSizes.sp15,
                ),
              ),
              Gap(AppSizes.h8),
              CustomTextFormField(
                hintText: 'Tamer Nabil',
                controller: fullNameController,
                keyboardType: TextInputType.name,
              ),
              Gap(AppSizes.h20),
              Text(
                'Email',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: AppSizes.sp15,
                ),
              ),
              Gap(AppSizes.h8),
              CustomTextFormField(
                hintText: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              Gap(AppSizes.h20),
              Text(
                'Password',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: AppSizes.sp15,
                ),
              ),
              Gap(AppSizes.h8),
              CustomTextFormField(
                hintText: 'Enter your password',
                prefixIcon: Icons.lock_outline_rounded,
                suffixIcon: _showPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                onSuffixPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),
              Gap(AppSizes.h40),
              ElevatedButton(onPressed: () {}, child: const Text('Sign Up')),
              Gap(AppSizes.h35),
              SocialAuthButton(),
              Gap(AppSizes.h28),
              AuthSwitchText(
                firstText: 'Already have an account? ',
                secondText: 'Login',
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>  YearSelectionScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
