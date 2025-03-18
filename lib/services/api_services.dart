import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String apiKey = 'a132ebc2f63eeef05d1f3ce769c48a86';
  static const String baseUrl = 'http://api.mediastack.com/v1/news';

  Future<List<dynamic>> fetchNews() async {
    final Uri url = Uri.parse('$baseUrl?access_key=$apiKey&countries=in&languages=en');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to load news');
    }
  }

}
