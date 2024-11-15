import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/movie.dart';

class ApiServices {
  final String _baseUrl = 'https://api.themoviedb.org/3/';
  final String _bearerToken = dotenv.env['BEARER_TOKEN'] ?? '';
  int totalPages = 0;
  Map<String, String> get userHeaders {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_bearerToken'
    };
  }

  Future<List<Movie>> searchMovie({required String query}) async {
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

  Future<List<Movie>> searchMovieWithFilters(
    String query, {
    int? year,
    String? genre,
    double? minRating,
    int page = 1,
  }) async {
    String url = '$_baseUrl/search/movie?query=$query&page=$page';

    if (genre != null) url += '&genre=$genre';
    if (year != null) url += '&year=$year';
    if (minRating != null) url += 'vote_average.gte=$minRating';

    try {
      final response = await http.get(Uri.parse(url), headers: userHeaders);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        totalPages = data['total_pages'];
        List<Movie> movies = (data['results'] as List)
            .map((movieData) => Movie.fromJson(movieData))
            .toList();
        return movies;
      } else {
        throw Exception('Error al cargar peliculas');
      }
    } catch (error) {
      print('Error en la búsqueda: $error');
      return [];
    }
  }

  Future<List<Genre>> getGenresMovies() async {
    String url = 'https://api.themoviedb.org/3/genre/movie/list';

    try {
      final response = await http.get(Uri.parse(url), headers: userHeaders);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Genre> genres = (data['genres'] as List)
            .map((genreData) => Genre.fromJson(genreData))
            .toList();
        return genres;
      } else {
        throw Exception('Error al cargar géneros de películas');
      }
    } catch (error) {
      print('Error al cargar géneros: $error');
      return [];
    }
  }
}
