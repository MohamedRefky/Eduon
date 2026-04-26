class MessageAiModel {
  final String text;
  final bool isMe;

  MessageAiModel({required this.text, required this.isMe});

  Map<String, dynamic> toMap() {
    return {'text': text, 'isMe': isMe};
  }

  factory MessageAiModel.fromMap(Map<String, dynamic> map) {
    return MessageAiModel(text: map['text'] ?? '', isMe: map['isMe'] ?? false);
  }
}
