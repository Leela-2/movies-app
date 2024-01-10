import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = '377dbf07dd3b123fcd46030235dc3e2d';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<dynamic>> getMovies(String endpoint) async {
    final response =
        await http.get(Uri.parse('$baseUrl$endpoint?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
