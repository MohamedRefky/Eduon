import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'package:eduon/features/auth/cubit/auth_cubit.dart';
import 'package:eduon/features/auth/screens/login_screen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      height: AppSizes.h56,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSizes.r15),
        border: Border.all(
          color: Colors.red.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: TextButton.icon(
        onPressed: () async {
          await context.read<AuthCubit>().logout();

          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false,
            );
          }
        },
        icon: Icon(Icons.logout, color: Colors.red, size: AppSizes.sp22),
        label: Text(
          l10n.logout,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Colors.red,
            fontSize: AppSizes.sp16,
          ),
        ),
      ),
    );
  }
}
