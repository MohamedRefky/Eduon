import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/models/message_ai_model.dart';
import 'package:eduon/features/eduon_aI/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class MessagesList extends StatefulWidget {
  final List<MessageAiModel> messages;
  final bool isTyping;

  const MessagesList({
    super.key,
    required this.messages,
    this.isTyping = false,
  });

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void didUpdateWidget(MessagesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length > oldWidget.messages.length) {
      Future.delayed(const Duration(milliseconds: 300), _scrollToBottom);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.messages.length + (widget.isTyping ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < widget.messages.length) {
            return MessageBubble(message: widget.messages[index]);
          } else {
            return Padding(
              padding: EdgeInsets.all(AppSizes.h12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "AI is typing",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Gap(AppSizes.h4),
                  Transform.translate(
                    offset: const Offset(0, 3.5),
                    child: Lottie.asset(
                      'assets/gif/typing_dots.json',
                      height: AppSizes.h8,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
