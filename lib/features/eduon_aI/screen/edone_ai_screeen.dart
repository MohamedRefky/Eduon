import 'package:eduon/core/widgets/custom_header.dart';
import 'package:eduon/features/courses/widgets/header_section.dart';
import 'package:eduon/features/eduon_aI/cubit/ai_cubit.dart';
import 'package:eduon/core/service/ai_service.dart';
import 'package:eduon/features/eduon_aI/widgets/chat_input_field.dart';
import 'package:eduon/features/eduon_aI/widgets/messages_list.dart';
import 'package:eduon/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EdoneAiScreen extends StatelessWidget {
  const EdoneAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiCubit(AiService()),
      child: const _EdoneAiScreenContent(),
    );
  }
}

class _EdoneAiScreenContent extends StatefulWidget {
  const _EdoneAiScreenContent();

  @override
  State<_EdoneAiScreenContent> createState() => _EdoneAiScreenContentState();
}

class _EdoneAiScreenContentState extends State<_EdoneAiScreenContent> {
  late TextEditingController _inputController;

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

  void _handleSendMessage() {
    if (_inputController.text.trim().isEmpty) return;

    final cubit = context.read<AiCubit>();
    cubit.sendMessage(_inputController.text.trim());
    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: BlocBuilder<AiCubit, AiState>(
        builder: (context, state) {
          final cubit = context.read<AiCubit>();
          final messages = cubit.messages;
          final isLoading = state is AiLoading;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomHeader(),
              MessagesList(messages: messages, isTyping: isLoading),
              ChatInputField(
                controller: _inputController,
                onSend: _handleSendMessage,
                isLoading: isLoading,
              ),
            ],
          );
        },
      ),
    );
  }
}
