import 'dart:io';

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/eduon_ai/cubit/ai_cubit.dart';
import 'package:eduon/core/service/ai_service.dart';
import 'package:eduon/features/eduon_ai/widgets/chat_input_field.dart';
import 'package:eduon/features/eduon_ai/widgets/messages_list.dart';
import 'package:eduon/core/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EduonAiScreen extends StatelessWidget {
  const EduonAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiCubit(AiService()),
      child: const _EduonAiScreenContent(),
    );
  }
}

class _EduonAiScreenContent extends StatefulWidget {
  const _EduonAiScreenContent();

  @override
  State<_EduonAiScreenContent> createState() => _EduonAiScreenContentState();
}

class _EduonAiScreenContentState extends State<_EduonAiScreenContent> {
  late TextEditingController _inputController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _handleSendMessage() {
    if (_inputController.text.trim().isEmpty && _selectedImage == null) return;

    final cubit = context.read<AiCubit>();
    cubit.sendMessage(_inputController.text.trim(), image: _selectedImage);

    setState(() {
      _selectedImage = null;
    });
    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(),
      extendBodyBehindAppBar: false,
      body: BlocBuilder<AiCubit, AiState>(
        builder: (context, state) {
          final cubit = context.read<AiCubit>();
          final messages = cubit.messages;
          final isLoading = state is AiLoading;

          return Column(
            children: [
              Expanded(
                child: MessagesList(messages: messages, isTyping: isLoading),
              ),
              if (_selectedImage != null)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.w16,
                    vertical: AppSizes.h8,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        child: Image.file(
                          _selectedImage!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedImage = null),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red.withValues(alpha: 0.8),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ChatInputField(
                controller: _inputController,
                onSend: _handleSendMessage,
                onPickImage: _pickImage,
                isLoading: isLoading,
              ),
            ],
          );
        },
      ),
    );
  }
}
