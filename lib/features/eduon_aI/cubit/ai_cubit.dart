import 'package:eduon/features/eduon_aI/model/message_model.dart';
import 'package:eduon/features/eduon_aI/services/ai_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  final AiService aiService;
  final List<MessageModel> _messages = [];

  AiCubit(this.aiService) : super(const AiInitial());

  List<MessageModel> get messages => _messages;

  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    // Add user message
    _messages.add(MessageModel(text: userMessage, isMe: true));
    emit(AiSuccess(List.from(_messages)));

    // Start loading
    emit(const AiLoading());

    try {
      // Get AI response
      final aiResponse = await aiService.sendMessage(userMessage);

      // Add AI message
      _messages.add(MessageModel(text: aiResponse, isMe: false));
      emit(AiSuccess(List.from(_messages)));
    } catch (e) {
      emit(AiError(e.toString()));
      // Still show error in messages
      _messages.add(MessageModel(text: "⚠️ Error occurred", isMe: false));
      emit(AiSuccess(List.from(_messages)));
    }
  }

  void clearMessages() {
    _messages.clear();
    emit(const AiInitial());
  }
}
