import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class OpenInYoutubeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const OpenInYoutubeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.h16),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.play_circle_fill),
        label: const Text('Open in YouTube'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
