import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback? onPickImage;
  final bool isLoading;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
    this.onPickImage,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.all(AppSizes.h12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTapUpOutside: (_) => FocusScope.of(context).unfocus(),
              controller: controller,
              enabled: !isLoading,
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: AppSizes.sp16,
              ),
              decoration: InputDecoration(
                hintText: l10n.ask_ai,
                fillColor: Theme.of(context).cardColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w16,
                  vertical: AppSizes.h12,
                ),
                prefixIcon: onPickImage != null
                    ? IconButton(
                        icon: const Icon(Icons.add_photo_alternate_rounded),
                        color: Theme.of(context).colorScheme.primary,
                        splashRadius: AppSizes.r20,
                        onPressed: isLoading ? null : onPickImage,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r30),
                  borderSide: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          Gap(AppSizes.w8),
          GestureDetector(
            onTap: isLoading ? null : onSend,
            child: Container(
              height: AppSizes.h45,
              width: AppSizes.h45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF607290)],
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      height: AppSizes.h20,
                      width: AppSizes.h20,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : Directionality(
                      textDirection: Directionality.of(context),
                      child: const Icon(Icons.send_outlined, color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
