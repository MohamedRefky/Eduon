class MessageAiModel {
  final String text;
  final bool isMe;
  final String? imagePath;

  MessageAiModel({required this.text, required this.isMe, this.imagePath});

  Map<String, dynamic> toMap() {
    return {'text': text, 'isMe': isMe, 'imagePath': imagePath};
  }

  factory MessageAiModel.fromMap(Map<String, dynamic> map) {
    return MessageAiModel(
      text: map['text'] ?? '', 
      isMe: map['isMe'] ?? false,
      imagePath: map['imagePath'],
    );
  }
}
