// lib/core/service/ai_service.dart

import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {
  late final GenerativeModel _model;

  AiService() {
    final apiKey = dotenv.env['GOOGLE_GENERATIVE_AI_API_KEY'] ?? '';

    try {
      _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
    } catch (e) {
      // Error handling without print
    }
  }

  Future<String> sendMessage(String message, {File? image}) async {
    if (message.isEmpty && image == null) {
      return "Please enter a message or select an image";
    }

    try {
      final List<Content> content;

      if (image != null) {
        final bytes = await image.readAsBytes();
        content = [
          Content.multi([
            TextPart(message.isEmpty ? "What is in this image?" : message),
            DataPart('image/jpeg', bytes),
          ]),
        ];
      } else {
        content = [Content.text(message)];
      }

      final response = await _model.generateContent(content);

      if (response.text == null) {
        return "⚠️ No response generated from Gemini.";
      }

      return response.text!;
    } catch (e) {
      if (e.toString().contains('API_KEY_INVALID')) {
        return "❌ Invalid API Key. Please check your .env file.";
      } else if (e.toString().contains('QUOTA_EXCEEDED')) {
        return "❌ API Quota exceeded. Please try again later.";
      }
      return "❌ Error: $e";
    }
  }
}
