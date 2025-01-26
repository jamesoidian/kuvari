import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kuha_app/models/kuha_image.dart';


class KuhaService {
  static Future<List<KuhaImage>> searchImages(String query) async {
    // Rakennetaan URL:
    final url = Uri.parse('https://kuha.papunet.net/api/search/all/$query?lang=fi');

    // Tehdään HTTP GET -kutsu:
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parsitaan JSON:
      final data = jsonDecode(response.body);
      final List imagesList = data['images'] ?? [];

      // Muutetaan jokainen imagesList:in alkio KuhaImage-olioksi
      return imagesList.map((json) => KuhaImage.fromJson(json)).toList();
    } else {
      // Heitetään virhe, jos statuskoodi ei ole 200
      throw Exception('Failed to fetch images');
    }
  }
}
