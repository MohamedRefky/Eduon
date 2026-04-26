import 'package:eduon/features/courses/bloc/courses_bloc.dart';
import 'package:eduon/features/courses/bloc/courses_event.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (_) => FocusScope.of(context).unfocus(),

      onChanged: (value) {
        context.read<CoursesBloc>().add(SearchPlaylistsEvent(value));
      },

      cursorColor: const Color(0xFF51565F),
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
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
