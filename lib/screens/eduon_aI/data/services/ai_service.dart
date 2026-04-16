import 'package:dio/dio.dart';

class AiService {
  final Dio dio;

  AiService(this.dio);

  Future<String> sendMessage({
    required String message,
    required String apiKey,
    required String model,
  }) async {
    final response = await dio.post(
      "/chat/completions",
      data: {
        "model": model,
        "max_tokens": 300,
        "messages": [
          {"role": "user", "content": message},
        ],
      },
      options: Options(headers: {"Authorization": "Bearer $apiKey"}),
    );

    return response.data["choices"][0]["message"]["content"] ?? "No response";
  }
}
