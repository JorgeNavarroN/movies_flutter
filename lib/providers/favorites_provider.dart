import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/services/save_service.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Movie> _favorites = [];
  bool isLoading = true;
  List<Movie> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    isLoading = true;
    notifyListeners();
    List<Movie> loadedMovies = await getFavoritesMovies();
    _favorites.addAll(loadedMovies);
    isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(Movie movie) {
    if (isFavorite(movie)) {
      _favorites.removeWhere((element) => element.id == movie.id);
      deleteFavoriteMovie(movie);
    } else {
      _favorites.add(movie);
      saveFavoritesMovies(movie);
    }
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    bool isFavorite = _favorites.any((element) => movie.id == element.id);
    return isFavorite;
  }
}
