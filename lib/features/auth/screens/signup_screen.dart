import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/utils/app_validator.dart';
import 'package:eduon/core/widgets/custom_text_form_field.dart';
import 'package:eduon/features/auth/cubit/auth_cubit.dart';
import 'package:eduon/core/widgets/custom_snack_bar.dart';
import 'package:eduon/features/auth/widgets/auth_switch_text.dart';
import 'package:eduon/features/auth/widgets/signup_header.dart';
import 'package:eduon/features/auth/widgets/social_auth_button.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:eduon/features/year_selection/year_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'package:eduon/core/widgets/language_toggle.dart';
import 'package:eduon/core/utils/auth_error_ext.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          if (state.isNewUser) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => YearSelectionScreen()),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
            );
          }
        }

        if (state is AuthError) {
          showCustomSnackBar(
            context,
            message: state.message.translateAuthError(context),
            type: SnackBarType.error,
          );
        }

        if (state is AuthCanceled) {
          showCustomSnackBar(
            context,
            message: AppLocalizations.of(context)!.signin_canceled,
            type: SnackBarType.info,
            duration: const Duration(seconds: 2),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: LanguageToggle(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.w20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(AppSizes.h10),
                    const SignUpHeader(),
                    Gap(AppSizes.h15),
                    Text(
                      AppLocalizations.of(context)!.full_name,
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontSize: AppSizes.sp15,
                      ),
                    ),
                    Gap(AppSizes.h8),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.full_name,
                      controller: cubit.fullNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) => AppValidator.fullName(value, AppLocalizations.of(context)!),
                    ),

                    Gap(AppSizes.h20),
                    Text(
                      AppLocalizations.of(context)!.email,
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontSize: AppSizes.sp15,
                      ),
                    ),
                    Gap(AppSizes.h8),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.enter_email,
                      prefixIcon: Icons.email_outlined,
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => AppValidator.email(value, AppLocalizations.of(context)!),
                    ),

                    Gap(AppSizes.h20),
                    Text(
                      AppLocalizations.of(context)!.password,
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontSize: AppSizes.sp15,
                      ),
                    ),
                    Gap(AppSizes.h8),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return CustomTextFormField(
                          hintText: AppLocalizations.of(
                            context,
                          )!.enter_password,
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: !cubit.showPassword,
                          suffixIcon: cubit.showPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          onSuffixPressed: cubit.togglePasswordVisibility,
                          controller: cubit.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => AppValidator.password(value, AppLocalizations.of(context)!),
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
                          : Text(AppLocalizations.of(context)!.signup),
                    ),
                    Gap(AppSizes.h35),
                    SocialAuthButton(
                      onTap: isLoading ? null : () => cubit.signInWithGoogle(),
                    ),
                    Gap(AppSizes.h28),
                    AuthSwitchText(
                      firstText:
                          '${AppLocalizations.of(context)!.already_have_account} ',
                      secondText: AppLocalizations.of(context)!.login,
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
