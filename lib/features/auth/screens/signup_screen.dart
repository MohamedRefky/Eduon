import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/auth/cubit/auth_cubit.dart';
import 'package:eduon/features/auth/utils/auth_snackbar.dart';
import 'package:eduon/features/auth/utils/auth_validator.dart';
import 'package:eduon/features/auth/widgets/auth_switch_text.dart';
import 'package:eduon/features/auth/widgets/custom_text_form_field.dart';
import 'package:eduon/features/auth/widgets/signup_header.dart';
import 'package:eduon/features/auth/widgets/social_auth_button.dart';
import 'package:eduon/features/year_selection/year_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => YearSelectionScreen()),
            (route) => false,
          );
        }

        if (state is AuthEmailAlreadyExists) {
          context.showAuthSnackBar(
            'Email already registered. Please login',
            isError: true,
          );
        }

        if (state is AuthCanceled) {
          context.showAuthSnackBar('Sign in canceled', durationSeconds: 2);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.w20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(AppSizes.h80),
                    const SignUpHeader(),
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
                      controller: cubit.fullNameController,
                      keyboardType: TextInputType.name,
                      validator: AuthValidator.fullName,
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

                    Gap(AppSizes.h40),

                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) return;
                              cubit.register();
                            },
                      child: isLoading
                          ? Lottie.asset(
                              height: AppSizes.h52,
                              'assets/gif/Loading_animation_blue.json',
                              fit: BoxFit.contain,
                            )
                          : const Text('Sign Up'),
                    ),
                    Gap(AppSizes.h35),
                    SocialAuthButton(
                      onTap: isLoading ? null : () => cubit.signInWithGoogle(),
                    ),
                    Gap(AppSizes.h28),
                    AuthSwitchText(
                      firstText: 'Already have an account? ',
                      secondText: 'Login',
                      ontap: () => Navigator.pop(context),
                    ),
                    Gap(AppSizes.h30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
