import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            SvgPicture.asset('assets/svg/Ai.svg'),
            const SizedBox(width: 8),
          ],

          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xff3E5F8A) : const Color(0xffF1F1F1),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(22),
                  topRight: const Radius.circular(22),
                  bottomLeft: Radius.circular(isMe ? 22 : 6),
                  bottomRight: Radius.circular(isMe ? 6 : 22),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                message["text"],
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),

          if (isMe) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 16,
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
      backgroundColor: const Color(0xffE9EEF3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Eduon AI", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("AI is typing..."),
            ),

          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Ask AI anything...",
                filled: true,
                fillColor: const Color(0xffF3F4F6),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff3E5F8A),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
