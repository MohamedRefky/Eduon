import 'package:dio/dio.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EdoneAiScreen extends StatefulWidget {
  const EdoneAiScreen({super.key});

  @override
  State<EdoneAiScreen> createState() => _EdoneAiScreenState();
}

class _EdoneAiScreenState extends State<EdoneAiScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [];

  bool _isTyping = false;

  final String _apiKey =
      "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";
  final String _model = "arcee-ai/trinity-large-preview:free"; // fast
  // final String _model = "z-ai/glm-4.5-air:free"; // slow

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://openrouter.ai/api/v1",
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<String> _sendToAI(String message) async {
    try {
      final response = await _dio.post(
        "/chat/completions",
        data: {
          "model": _model,
          "max_tokens": 300,
          "messages": [
            {"role": "user", "content": message},
          ],
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $_apiKey",
            "HTTP-Referer": "https://eduon.app",
            "X-Title": "Eduon AI",
          },
        ),
      );

      return response.data["choices"][0]["message"]["content"] ?? "No response";
    } catch (e) {
      return "⚠️ Error occurred";
    }
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    String userMessage = _controller.text.trim();

    setState(() {
      _messages.add({"text": userMessage, "isMe": true});
      _isTyping = true;
    });

    _controller.clear();
    _scrollToBottom();

    final reply = await _sendToAI(userMessage);

    setState(() {
      _messages.add({"text": reply, "isMe": false});
      _isTyping = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final bool isMe = message["isMe"];

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.h6,
        horizontal: AppSizes.w10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            SvgPicture.asset('assets/svg/Ai.svg'),
            Gap(AppSizes.h8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.all(AppSizes.h16),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFF305073) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.r24),
                  topRight: Radius.circular(AppSizes.r24),
                  bottomLeft: Radius.circular(
                    isMe ? AppSizes.r24 : AppSizes.r2,
                  ),
                  bottomRight: Radius.circular(
                    isMe ? AppSizes.r2 : AppSizes.r24,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                message["text"],
                style: TextStyle(
                  fontSize: AppSizes.h15,
                  height: 1.5,
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),

          if (isMe) ...[
            Gap(AppSizes.h8),
            CircleAvatar(
              radius: AppSizes.r16,
              backgroundImage: AssetImage("assets/images/Avatar.png"),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
            );
          },
          child: Icon(Icons.arrow_back),
        ),
        title: const Text('Eduon AI'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),

          if (_isTyping)
            Padding(
              padding: EdgeInsets.all(AppSizes.h12),
              child: Text("AI is typing..."),
            ),

          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: EdgeInsets.all(AppSizes.h12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTapUpOutside: (_) => FocusScope.of(context).unfocus(),
              controller: _controller,
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.grey[600],
                fontSize: AppSizes.sp16,
              ),
              decoration: InputDecoration(
                hintText: "Ask AI anything...",
                fillColor: const Color(0xffffffff),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Gap(AppSizes.w8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              height: AppSizes.h45,
              width: AppSizes.w45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF607290)],
                ),
              ),
              child: const Icon(Icons.send_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
