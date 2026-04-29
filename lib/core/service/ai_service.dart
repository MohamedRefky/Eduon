import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {
  final String _apiKey = dotenv.env['OPENROUTER_API_KEY'] ?? '';

  final String _model =
      "nvidia/nemotron-3-super-120b-a12b:free"; // The best model

  //final String _model = "inclusionai/ling-2.6-flash:free"; // The fastest model

  late final Dio _dio;

  AiService({Dio? dio}) {
    _dio =
        dio ??
        Dio(
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
