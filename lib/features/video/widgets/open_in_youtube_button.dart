import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OpenInYoutubeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const OpenInYoutubeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.play_circle_fill),
        label: Text(l10n.open_in_youtube),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
