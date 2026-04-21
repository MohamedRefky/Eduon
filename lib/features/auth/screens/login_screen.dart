import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/auth_service.dart';
import 'package:eduon/features/auth/cubit/auth_cubit.dart';
import 'package:eduon/features/auth/screens/signup_screen.dart';
import 'package:eduon/features/auth/utils/auth_snackbar.dart';
import 'package:eduon/features/auth/utils/auth_validator.dart';
import 'package:eduon/features/auth/widgets/auth_switch_text.dart';
import 'package:eduon/features/auth/widgets/custom_text_form_field.dart';
import 'package:eduon/features/auth/widgets/login_header.dart';
import 'package:eduon/features/auth/widgets/social_auth_button.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthService()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
            );
          }

          if (state is AuthUserNotFound) {
            context.showAuthSnackBar(
              "User not found. Please sign up first.",
              isError: true,
            );
          }
          if (state is AuthPasswordResetSent) {
            context.showAuthSnackBar('Password reset link sent to your email');
          }

          if (state is AuthError) {
            context.showAuthSnackBar(state.message, isError: true);
          }
          if (state is AuthCanceled) {
            context.showAuthSnackBar('Sign in canceled', durationSeconds: 2);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          final theme = Theme.of(context);
          final isLoading = state is AuthLoading;

          return Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.w20),
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
                      validator: AuthValidator.email,
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
                          validator: AuthValidator.password,
                        );
                      },
                    ),
                    Gap(AppSizes.h8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: isLoading
                            ? null
                            : () {
                                final email = cubit.emailController.text.trim();

                                if (email.isEmpty) {
                                  context.showAuthSnackBar(
                                    "Enter your email first",
                                    isError: true,
                                  );
                                  return;
                                }

                                cubit.forgotPasswordWithEmail(email);
                                if (state is AuthPasswordResetSent) {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: const Text("Check your email"),
                                        content: const Text(
                                          "We sent a password reset link to your email address.",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
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
                              child: const CircularProgressIndicator(
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
                              child: SignUpScreen(),
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
      ),
    );
  }
}
