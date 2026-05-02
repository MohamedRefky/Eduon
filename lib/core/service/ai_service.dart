// lib/core/service/ai_service.dart

import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {
  late final GenerativeModel _model;

  AiService() {
    final apiKey = dotenv.env['GOOGLE_GENERATIVE_AI_API_KEY'] ?? '';

    if (apiKey.isEmpty) {
      print('❌ AI_SERVICE: API Key is missing from .env file!');
    } else {
      print(
        '✅ AI_SERVICE: API Key loaded successfully (Starts with: ${apiKey.substring(0, 5)}...)',
      );
    }

    try {
      // استخدام الموديل الرسمي gemini-1.5-flash
      _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    } catch (e) {
      print('❌ AI_SERVICE_INIT_ERROR: $e');
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

      // إرسال الطلب
      final response = await _model.generateContent(content);

      if (response.text == null) {
        return "⚠️ No response generated from Gemini.";
      }

      return response.text!;
    } catch (e) {
      print('❌ AI_SERVICE_SEND_ERROR: $e');

      if (e.toString().contains('not found')) {
        return "⚠️ Gemini Error: Model not found. This usually means your API Key is invalid or not authorized for this model. Please get a new key from https://aistudio.google.com/";
      }

      return "⚠️ Error: ${e.toString()}";
    }
  }
}
