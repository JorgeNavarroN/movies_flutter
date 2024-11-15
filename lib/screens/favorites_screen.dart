import 'package:flutter/material.dart';
import 'package:movies_app/providers/favorites_provider.dart';
import 'package:movies_app/widgets/movie_description.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
      ),
      body: ListView.builder(
        itemCount: favoritesProvider.favorites.length,
        itemBuilder: (context, index) {
          final movie = favoritesProvider.favorites[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  child: SizedBox(
                    height: 150,
                    width: 100,
                    child: movie.posterPath != ''
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover)
                        : Image.asset(
                            'assets/images/placeholder.png',
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: MovieDescription(
                      title: movie.title,
                      description: movie.description,
                      voteAverage: movie.voteAverage.toStringAsFixed(1),
                      voteCount: movie.voteCount.toStringAsFixed(1),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
