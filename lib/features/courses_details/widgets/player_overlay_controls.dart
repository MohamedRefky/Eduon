import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class PlayerOverlayControls extends StatelessWidget {
  final bool canPlayPrevious;
  final bool canPlayNext;
  final String currentTitle;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const PlayerOverlayControls({
    super.key,
    required this.canPlayPrevious,
    required this.canPlayNext,
    required this.currentTitle,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // Previous Button
          PositionedDirectional(
            start: AppSizes.h40,
            top: 0,
            bottom: 0,
            child: Center(
              child: _OverlayButton(
                icon: Icons.skip_previous,
                isEnabled: canPlayPrevious,
                onTap: canPlayPrevious ? onPrevious : null,
              ),
            ),
          ),

          // Next Button
          PositionedDirectional(
            end: AppSizes.h40,
            top: 0,
            bottom: 0,
            child: Center(
              child: _OverlayButton(
                icon: Icons.skip_next,
                isEnabled: canPlayNext,
                onTap: canPlayNext ? onNext : null,
              ),
            ),
          ),

          // Video Title
          if (currentTitle.isNotEmpty)
            PositionedDirectional(
              top: AppSizes.h8,
              start: AppSizes.h40,
              end: AppSizes.h40,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w8,
                  vertical: AppSizes.h4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                ),
                child: Text(
                  currentTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: AppSizes.sp12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _OverlayButton extends StatelessWidget {
  final IconData icon;
  final bool isEnabled;
  final VoidCallback? onTap;

  const _OverlayButton({
    required this.icon,
    required this.isEnabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.h8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Transform.flip(
          flipX: Directionality.of(context) == TextDirection.rtl,
          child: Icon(
            icon,
            color: isEnabled ? Colors.white : Colors.white38,
            size: AppSizes.sp30,
          ),
        ),
      ),
    );
  }
}
