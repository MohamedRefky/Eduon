import 'package:dio/dio.dart';

class AiService {
  final String _apiKey =
      "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";
  //final String _model = "arcee-ai/trinity-large-preview:free";
  //final String _model = "nvidia/nemotron-3-super-120b-a12b:free";
  final String _model = "inclusionai/ling-2.6-flash:free";

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
