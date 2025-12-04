// lib/services/kuvari_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kuvari_app/models/kuvari_image.dart';

import 'package:cloud_functions/cloud_functions.dart';

class KuvariService {
  final http.Client client;

  KuvariService({http.Client? client}) : client = client ?? http.Client();

  Future<List<KuvariImage>> searchImages(String query, List<String> categories, String languageCode) async {
    if (languageCode == 'en') {
      return _searchOpenSymbols(query);
    }

    final categoriesString = categories.isEmpty ? 'all' : categories.join('-');

    // Muunnetaan 'sv' -> 'se', jos tarpeen
    final apiLanguageCode = languageCode == 'sv' ? 'se' : languageCode;

    // Rakennetaan URL käyttäen oikeaa kielikoodia:
    final url = Uri.parse('https://kuha.papunet.net/api/search/$categoriesString/$query?lang=$apiLanguageCode');

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

  Future<List<KuvariImage>> _searchOpenSymbols(String query) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('searchOpenSymbols')
          .call({'query': query});

      final List<dynamic> data = result.data;
      return data.map((json) => KuvariImage.fromJson(Map<String, dynamic>.from(json as Map))).toList();
    } catch (e) {
      throw Exception('Failed to fetch images from OpenSymbols: $e');
    }
  }
}
