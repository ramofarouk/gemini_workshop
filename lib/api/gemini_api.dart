import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiApi {
  GeminiApi({required String type})
      : _model = GenerativeModel(
          model: type,
          apiKey: dotenv.get("API_KEY"),
        );

  final GenerativeModel _model;

  Future<String?> generateObjects(String location) async {
    final prompt = '''
    Vous êtes un jeu où les objets sont trouvés en les prenant en photo. Créez une liste de 5 objets qui pourraient être trouvés $location.
    Les objets doivent être faciles à trouver, mais certains peuvent être un peu plus difficiles à trouver. Le nom de l'objet doit être concis.
    Toutes les lettres doivent être majuscules. N'incluez pas d'articles (un, une, le ou la).
    Fournissez votre réponse sous le format suivant : {"items" : ["", "", ...]}.
    Ne pas renvoyez le résultat sous forme de Markdown.
    ''';

    final response = await _model.generateContent([
      Content.text(prompt),
    ]);

    print(response.text);

    return response.text;
  }

  Future<String?> validateImage(String item, Uint8List image) async {
    final prompt = '''
    Vous êtes un jeu où l'on trouve des objets en les prenant en photo.
    On vous a donné l'objet "$item" et une photo de l'objet.
    Déterminez si la photo est une photo valide de l'objet et donnez une note entre 0 à 100 du matching.
    Fournissez votre réponse sous le format suivant : {"valid" : true/false,"score" : 0/100}.
    Ne pas renvoyez le résultat sous forme de Markdown.
    ''';

    final response = await _model.generateContent([
      Content.multi([TextPart(prompt), DataPart('image/jpeg', image)]),
    ]);

    return response.text;
  }
}
