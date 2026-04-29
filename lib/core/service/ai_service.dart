import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {
  late final GenerativeModel _model;

  AiService() {
    final apiKey = dotenv.env['GOOGLE_GENERATIVE_AI_API_KEY'] ?? '';

    // Using the latest available model for your API Key
    _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
  }

  Future<String> sendMessage(String message, {File? image}) async {
    if (message.isEmpty && image == null) return "Please enter a message or select an image";

    try {
      final List<Content> content;
      
      if (image != null) {
        final bytes = await image.readAsBytes();
        content = [
          Content.multi([
            TextPart(message.isEmpty ? "What is in this image?" : message),
            DataPart('image/jpeg', bytes),
          ])
        ];
      } else {
        content = [Content.text(message)];
      }

      final response = await _model.generateContent(content);
      return response.text ?? "⚠️ No response generated";
    } catch (e) {
      return "⚠️ Sorry, an error occurred while connecting to AI. Please check your internet connection or try again later.";
    }
  }
}
