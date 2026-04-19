import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onSuffixPressed,
    required this.keyboardType,
  });
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function()? onSuffixPressed;
  final TextInputType keyboardType;
 
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: const Color(0xFF94A3B8),
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: keyboardType,
      onTapUpOutside: (_) => FocusScope.of(context).unfocus(),
      controller: controller,
      validator: validator,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.displayMedium,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
          vertical: AppSizes.h18,
          horizontal: AppSizes.w8,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: AppSizes.sp24)
            : null,
        suffixIcon: IconButton(
          onPressed: onSuffixPressed,
          icon: Icon(suffixIcon, size: AppSizes.sp22),
        ),
      ),
    );
  }
}
