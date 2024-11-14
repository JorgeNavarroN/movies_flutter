import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/movie.dart';

class ApiServices {
  final String _baseUrl = 'https://api.themoviedb.org/3/';
  final String _bearerToken = dotenv.env['BEARER_TOKEN'] ?? '';
  Map<String, String> get userHeaders {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_bearerToken'
    };
  }

  Future<List<Movie>> searchMovie(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search/movie?query=$query'),
      headers: userHeaders,
    );
    print("Codigo de estado: ${response.statusCode}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      List<Movie> movies = (data['results'] as List)
          .map((movieData) => Movie.fromJson(movieData))
          .toList();
      return movies;
    } else {
      throw Exception('Error al cargar peliculas');
    }
  }
}
