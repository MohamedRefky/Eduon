import 'dart:io';

import 'package:eduon/features/eduon_ai/data/models/message_ai_model.dart';
import 'package:eduon/core/service/ai_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  final AiService aiService;
  final List<MessageAiModel> _messages = [];

  AiCubit(this.aiService) : super(const AiInitial());

  List<MessageAiModel> get messages => _messages;

  Future<void> sendMessage(String userMessage, {File? image}) async {
    if (userMessage.trim().isEmpty && image == null) return;

    // Add user message
    _messages.add(MessageAiModel(text: userMessage, isMe: true, imagePath: image?.path));
    emit(AiSuccess(List.from(_messages)));

    // Start loading
    emit(const AiLoading());

    try {
      // Get AI response
      final aiResponse = await aiService.sendMessage(userMessage, image: image);

      // Add AI message
      _messages.add(MessageAiModel(text: aiResponse, isMe: false));
      emit(AiSuccess(List.from(_messages)));
    } catch (e) {
      emit(AiError(e.toString()));
      // Still show error in messages
      _messages.add(MessageAiModel(text: "⚠️ Error occurred", isMe: false));
      emit(AiSuccess(List.from(_messages)));
    }
  }

  void clearMessages() {
    _messages.clear();
    emit(const AiInitial());
  }
}
