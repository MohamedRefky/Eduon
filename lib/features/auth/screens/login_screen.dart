import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/auth_service.dart';
import 'package:eduon/features/auth/cubit/auth_cubit.dart';
import 'package:eduon/features/auth/screens/signup_screen.dart';
import 'package:eduon/features/auth/widgets/auth_switch_text.dart';
import 'package:eduon/features/auth/widgets/custom_text_form_field.dart';
import 'package:eduon/features/auth/widgets/login_header.dart';
import 'package:eduon/features/auth/widgets/social_auth_button.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthService()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthSuccess():
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
            );
            break;

          case AuthError():
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    'Account not found. Please sign up first',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextTheme.of(context).labelMedium,
                  ),
                ),
                backgroundColor: Colors.red.shade600,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.symmetric(
                  horizontal: AppSizes.w16,
                  vertical: AppSizes.h12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                ),
                duration: const Duration(seconds: 3),
              ),
            );
            break;

          case AuthCanceled():
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Sign in canceled"),
                behavior: SnackBarBehavior.floating,
              ),
            );
            break;

          default:
            break;
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.w24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginHeader(),
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
                    controller: cubit.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please Enter Email';
                      }
                      final email = value.trim();
                      if (!email.contains('@')) {
                        return "Mast contain @ in email address";
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(email)) {
                        return 'Enter valid email (name@email.com)';
                      }
                      return null;
                    },
                  ),

                  Gap(AppSizes.h20),
                  Text(
                    'Password',
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontSize: AppSizes.sp15,
                    ),
                  ),
                  Gap(AppSizes.h8),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        hintText: 'Enter your password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: !cubit.showPassword,
                        suffixIcon: cubit.showPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        onSuffixPressed: cubit.togglePasswordVisibility,
                        controller: cubit.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter Password';
                          }
                          if (value.length < 6) {
                            return 'Password at least 6 characters';
                          }
                          return null;
                        },
                      );
                    },
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
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) return;
                            cubit.login();
                          },
                    child: isLoading
                        ? SizedBox(
                            height: AppSizes.h20,
                            width: AppSizes.w20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Login'),
                  ),
                  Gap(AppSizes.h35),
                  SocialAuthButton(
                    onTap: isLoading ? null : () => cubit.signInWithGoogle(),
                  ),
                  Gap(AppSizes.h28),
                  AuthSwitchText(
                    firstText: 'Don\'t have an account? ',
                    secondText: 'Sign Up',
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubit,
                            child: const SignUpScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                  Gap(AppSizes.h30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
