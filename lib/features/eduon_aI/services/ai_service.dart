import 'package:dio/dio.dart';

class AiService {
  final String _apiKey =
      "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";
  final String _model = "arcee-ai/trinity-large-preview:free";

  late final Dio _dio;

  AiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://openrouter.ai/api/v1",
        headers: {"Content-Type": "application/json"},
      ),
    );
  }

  Future<String> sendMessage(String message) async {
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
}
