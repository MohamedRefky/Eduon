// lib/features/profile/widgets/edit_profile_dialog.dart

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/utils/app_validator.dart';
import 'package:eduon/core/widgets/custom_text_form_field.dart';
import 'package:eduon/features/profile/cubit/profile_cubit.dart';
import 'package:eduon/features/profile/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eduon/l10n/app_localizations.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProfileCubit>();
    nameController.text = cubit.state.name ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final cubit = context.read<ProfileCubit>();
      cubit.updateName(nameController.text);
      cubit.saveProfile(AppLocalizations.of(context)!.profile_updated);

      Navigator.pop(context, true);
    }
  }

  String _getYearKey(String? year) {
    if (year == null) {
      return 'none';
    }
    if (year.contains('1') ||
        year.contains('First') ||
        year.contains('الأولى')) {
      return 'year1';
    }
    if (year.contains('2') ||
        year.contains('Second') ||
        year.contains('الثانية')) {
      return 'year2';
    }
    if (year.contains('3') ||
        year.contains('Third') ||
        year.contains('الثالثة')) {
      return 'year3';
    }
    if (year.contains('4') ||
        year.contains('Fourth') ||
        year.contains('الرابعة')) {
      return 'year4';
    }
    return 'none';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final years = [
      l10n.first_year,
      l10n.second_year,
      l10n.third_year,
      l10n.fourth_year,
    ];

    return Padding(
      padding: EdgeInsets.all(AppSizes.w20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ),

            /// Avatar
            BlocBuilder<ProfileCubit, ProfileState>(
              buildWhen: (prev, curr) =>
                  prev.displayImage != curr.displayImage ||
                  prev.isLoadingImage != curr.isLoadingImage,
              builder: (context, state) {
                return SizedBox(
                  width: AppSizes.h120,
                  height: AppSizes.h120,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _buildAvatar(state),
                      Positioned(
                        bottom: 3,
                        right: 10,
                        child: GestureDetector(
                          onTap: () => _showImageSourceDialog(context),
                          child: Container(
                            padding: EdgeInsets.all(AppSizes.h5),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            Gap(AppSizes.h40),

            CustomTextFormField(
              controller: nameController,
              labelText: l10n.full_name,
              keyboardType: TextInputType.text,
              validator: (value) => AppValidator.fullName(value, l10n),
            ),

            Gap(AppSizes.h30),

            /// Year Selector
            BlocBuilder<ProfileCubit, ProfileState>(
              buildWhen: (prev, curr) => prev.selectedYear != curr.selectedYear,
              builder: (context, state) {
                return MenuAnchor(
                  style: MenuStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                      ),
                    ),
                  ),
                  alignmentOffset: const Offset(0, 8),
                  builder: (context, controller, child) {
                    return GestureDetector(
                      onTap: () {
                        controller.isOpen
                            ? controller.close()
                            : controller.open();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.w16,
                          vertical: AppSizes.h16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(AppSizes.r15),
                        ),
                        child: Row(
                          children: [
                            Text(
                              l10n.academic_year(
                                _getYearKey(state.selectedYear),
                              ),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const Spacer(),
                            Icon(
                              controller.isOpen
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  menuChildren: years.map((e) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width - AppSizes.w40,
                      child: MenuItemButton(
                        onPressed: () {
                          context.read<ProfileCubit>().updateYear(e);
                        },
                        child: Text(
                          e,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            Gap(AppSizes.h50),

            /// Save Button
            Container(
              width: AppSizes.w200,
              height: AppSizes.h50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F172A),
                    const Color(0xFF64748B).withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppSizes.r20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSizes.r20),
                  onTap: _save,
                  child: Center(
                    child: Text(
                      l10n.save_changes,
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: const Color(0xFFE2F6FF),
                            fontSize: AppSizes.sp16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
            ),

            Gap(AppSizes.h260),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(ProfileState state) {
    return ClipOval(
      child: state.isLoadingImage
          ? const Center(child: CircularProgressIndicator())
          : (state.imagePath != null && state.imagePath!.isNotEmpty)
          ? (state.imagePath!.startsWith('http')
                ? Image.network(
                    state.imagePath!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : (state.displayImage != null &&
                          state.displayImage!.existsSync()
                      ? Image.file(
                          state.displayImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Image.asset(
                          'assets/images/Avatar.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )))
          : Image.asset(
              'assets/images/Avatar.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
    );
  }

  void _showImageSourceDialog(BuildContext parentContext) {
    final l10n = AppLocalizations.of(parentContext)!;
    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return Dialog(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text(
                  l10n.gallery,
                  style: Theme.of(
                    parentContext,
                  ).textTheme.displayMedium?.copyWith(fontSize: AppSizes.sp18),
                ),
                onTap: () {
                  Navigator.pop(dialogContext);
                  parentContext.read<ProfileCubit>().pickImage(
                    ImageSource.gallery,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(
                  l10n.camera,
                  style: Theme.of(
                    parentContext,
                  ).textTheme.displayMedium?.copyWith(fontSize: AppSizes.sp18),
                ),
                onTap: () {
                  Navigator.pop(dialogContext);
                  parentContext.read<ProfileCubit>().pickImage(
                    ImageSource.camera,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
