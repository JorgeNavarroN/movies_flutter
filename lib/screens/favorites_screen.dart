import 'package:flutter/material.dart';
import 'package:movies_app/providers/favorites_provider.dart';
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
          return ListTile(
            leading: Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
            title: Text(movie.title),
          );
        },
      ),
    );
  }
}
