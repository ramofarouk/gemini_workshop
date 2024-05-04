import 'dart:convert';
import 'dart:typed_data';

import 'package:gemini_game/api/gemini_api.dart';
import 'package:gemini_game/models/environment.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRepository {
  GeminiRepository({required GeminiApi client}) : _client = client;

  final GeminiApi _client;

  Future<List<String>> loadObjects(GameEnvironment gameEnvironment) async {
    final location = switch (gameEnvironment) {
      GameEnvironment.home => "à la maison",
      GameEnvironment.work => "au travail",
    };

    try {
      final response = await _client.generateObjects(location);

      if (response == null) {
        throw Exception("Response is null");
      }

      if (jsonDecode(response) case {'items': List<dynamic> items}) {
        return List<String>.from(items);
      }

      throw Exception("Invalid JSON schema");
    } on GenerativeAIException {
      throw Exception("Problem with the Generative AI");
    } catch (e) {
      throw Exception("Unknown error $e");
    }
  }

  Future<(bool, int)> validateImage(String item, Uint8List image) async {
    try {
      final response = await _client.validateImage(item, image);

      if (response == null) {
        throw Exception("Response is null");
      }

      if (jsonDecode(response) case {'valid': bool valid, 'score': int score}) {
        return (valid, score);
      }

      throw Exception("Invalid JSON schema");
    } on GenerativeAIException {
      throw Exception("Problem with the Generative AI");
    } catch (e) {
      throw Exception("Unknown error");
    }
  }
}
