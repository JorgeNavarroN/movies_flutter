import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Movie> _favorites = [];
  List<Movie> get favorites => _favorites;

  void toggleFavorite(Movie movie) {
    if (_favorites.contains(movie)) {
      _favorites.remove(movie);
    } else {
      _favorites.add(movie);
    }
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favorites.contains(movie);
  }
}
