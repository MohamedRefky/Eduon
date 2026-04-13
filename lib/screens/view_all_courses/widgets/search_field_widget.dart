import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      cursorColor: const Color(0xFF51565F),
      style: TextTheme.of(context).displayMedium?.copyWith(
            fontSize: AppSizes.sp16,
            fontWeight: FontWeight.w500,
          ),
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search for courses',
      ),
    );
  }
}