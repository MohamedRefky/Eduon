class MessageModel {
  final String text;
  final bool isMe;

  MessageModel({required this.text, required this.isMe});

  Map<String, dynamic> toMap() {
    return {'text': text, 'isMe': isMe};
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(text: map['text'] ?? '', isMe: map['isMe'] ?? false);
  }
}
