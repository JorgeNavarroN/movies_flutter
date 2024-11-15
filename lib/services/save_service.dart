import 'package:hive/hive.dart';
import 'package:movies_app/models/movie.dart';

void saveFavoritesMovies(Movie movie) async {
  var box = Hive.box<Movie>('movies_favorites');
  await box.add(movie);
}

Future<List<Movie>> getFavoritesMovies() async {
  var box = await Hive.openBox<Movie>('movies_favorites');
  List<Movie> favorites = box.values.toList();
  return favorites;
}

void deleteFavoriteMovie(Movie movie) async {
  var box = await Hive.openBox<Movie>('movies_favorites');
  int? index = box.values.toList().indexWhere((movie) => movie.id == movie.id);
  if (index != -1) await box.deleteAt(index);
}
