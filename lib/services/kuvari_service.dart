// lib/services/kuvari_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kuvari_app/models/kuvari_image.dart';

class KuvariService {
  final http.Client client;

  KuvariService({http.Client? client}) : client = client ?? http.Client();

  Future<List<KuvariImage>> searchImages(String query, List<String> categories, String languageCode) async {
    final categoriesString = categories.isEmpty ? 'all' : categories.join('-');

    // Rakennetaan URL:
    final url = Uri.parse('https://kuha.papunet.net/api/search/$categoriesString/$query?lang=$languageCode');

    // Tehdään HTTP GET -kutsu:
    final response = await client.get(url);

    if (response.statusCode == 200) {
      // Parsitaan JSON:
      final data = jsonDecode(response.body);
      final List imagesList = data['images'] ?? [];

      // Muutetaan jokainen imagesList:in alkio KuvariImage-olioksi
      return imagesList.map((json) => KuvariImage.fromJson(json)).toList();
    } else {
      // Heitetään virhe, jos statuskoodi ei ole 200
      throw Exception('Failed to fetch images');
    }
  }
}
