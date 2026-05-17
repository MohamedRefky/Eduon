// lib/features/profile/widgets/edit_profile_avatar.dart

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/localization/l10n/app_localizations.dart';
import 'package:eduon/features/profile/cubit/profile_cubit.dart';
import 'package:eduon/features/profile/cubit/profile_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ProfileCubit, ProfileState>(
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
                      color: colorScheme.onSurface.withValues(
                        alpha: 0.5,
                      ),
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
