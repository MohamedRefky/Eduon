part of 'ai_cubit.dart';

abstract class AiState extends Equatable {
  const AiState();

  @override
  List<Object> get props => [];
}

class AiInitial extends AiState {
  const AiInitial();
}

class AiLoading extends AiState {
  const AiLoading();
}

class AiSuccess extends AiState {
  final List<MessageModel> messages;

  const AiSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}

class AiError extends AiState {
  final String message;

  const AiError(this.message);

  @override
  List<Object> get props => [message];
}
