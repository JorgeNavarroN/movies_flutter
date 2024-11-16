import 'package:flutter/material.dart';
import 'package:movies_app/providers/favorites_provider.dart';
import 'package:movies_app/screens/movie_details_screen.dart';
import 'package:movies_app/widgets/movie_card.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: favoritesProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: favoritesProvider.favorites.length,
                      itemBuilder: (context, index) {
                        if (favoritesProvider.favorites.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Text(
                                'No hay películas favoritas',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        if (index == favoritesProvider.favorites.length) {
                          return const SizedBox();
                        }
                        final movie = favoritesProvider.favorites[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                  movie: movie,
                                ),
                              ),
                            );
                          },
                          child: MovieCard(movie: movie),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
