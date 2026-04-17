import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
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
                color: Colors.grey[600],
                fontSize: AppSizes.sp16,
              ),
              decoration: InputDecoration(
                hintText: "Ask AI anything...",
                fillColor: const Color(0xffffffff),
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
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Gap(AppSizes.w8),
          GestureDetector(
            onTap: isLoading ? null : onSend,
            child: Container(
              height: AppSizes.h45,
              width: AppSizes.w45,
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
                  : const Icon(Icons.send_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
