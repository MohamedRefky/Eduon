import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/prefrances_maneger.dart';
import 'package:eduon/core/utils/app_validator.dart';
import 'package:eduon/core/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final nameController = TextEditingController();

  String? selectedYear;
  String? imagePath;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final years = ['First Year', 'Second Year', 'Third Year', 'Fourth Year'];

  @override
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    nameController.text = PrefrancesManeger().getUserFullName(uid) ?? '';

    selectedYear = PrefrancesManeger().getUserSelectedYear(uid);
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      PrefrancesManeger().setUserFullName(uid, nameController.text);

      PrefrancesManeger().setUserSelectedYear(uid, selectedYear ?? '');

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.w20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Gap(AppSizes.h20),

            /// Avatar
            GestureDetector(
              onTap: () {
                // add image picker later
              },
              child: CircleAvatar(
                radius: AppSizes.h60,
                backgroundImage: imagePath != null
                    ? AssetImage(imagePath!)
                    : const AssetImage('assets/images/Avatar.png')
                          as ImageProvider,
              ),
            ),

            Gap(AppSizes.h30),

            CustomTextFormField(
              controller: nameController,
              labelText: 'Full Name',
              keyboardType: TextInputType.text,
              validator: AppValidator.fullName,
            ),

            Gap(AppSizes.h30),

            /// Year
            MenuAnchor(
              style: MenuStyle(
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.r12),
                  ),
                ),
              ),
              alignmentOffset: Offset(0, 8),
              builder: (context, controller, child) {
                return GestureDetector(
                  onTap: () {
                    controller.isOpen ? controller.close() : controller.open();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.w16,
                      vertical: AppSizes.h16,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(AppSizes.r15),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedYear ?? 'Select Year',
                          style: TextTheme.of(context).displayMedium,
                        ),
                        Spacer(),
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
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(
                          horizontal: AppSizes.w20,
                          vertical: AppSizes.h12,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedYear = e;
                      });
                    },
                    child: Text(e, style: TextTheme.of(context).displayMedium),
                  ),
                );
              }).toList(),
            ),
            Gap(AppSizes.h40),

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
                child: GestureDetector(
                  onTap: () {
                    save();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Save Changes',
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
          ],
        ),
      ),
    );
  }
}
