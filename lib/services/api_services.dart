import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/movie.dart';

class ApiServices {
  final String _apiKey = 'TU_API_KEY_AQUI';
  final String _baseUrl = 'https://api.themoviedb.org/3/';

  Future<List<Movie>> searchMovie(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Movie> movies = (data['results'] as List)
          .map((movieData) => Movie.fromJson(movieData))
          .toList();
      return movies;
    } else {
      throw Exception('Error al cargar peliculas');
    }
  }
}
