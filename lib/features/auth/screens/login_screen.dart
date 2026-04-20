import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/auth_service.dart';
import 'package:eduon/features/auth/screens/signup_screen.dart';
import 'package:eduon/features/auth/widgets/auth_switch_text.dart';
import 'package:eduon/features/auth/widgets/custom_text_form_field.dart';
import 'package:eduon/features/auth/widgets/login_header.dart';
import 'package:eduon/features/auth/widgets/social_auth_button.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _showPassword = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.w24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoginHeader(),
            Gap(AppSizes.h30),
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
            Gap(AppSizes.h8),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  'Forgot?',
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontSize: AppSizes.sp13,
                  ),
                ),
              ),
            ),
            Gap(AppSizes.h40),
            ElevatedButton(onPressed: () {}, child: const Text('Login')),
            Gap(AppSizes.h35),
            SocialAuthButton(
              onTap: () async {
                final user = await _authService.signInWithGoogle();
                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                  );
                }
              },
            ),
            Gap(AppSizes.h28),
            AuthSwitchText(
              firstText: 'Don\'t have an account? ',
              secondText: 'Sign Up',
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
