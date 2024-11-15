import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/providers/favorites_provider.dart';
import 'package:movies_app/widgets/vote_average_movie.dart';
import 'package:movies_app/widgets/vote_count_movie.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String imageEndpoint = dotenv.env['IMAGE_ENDPOINT'] ?? '';
  final Movie movie;

  MovieDetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (movie.posterPath != '')
                Image.network(
                  '$imageEndpoint${movie.posterPath}',
                  fit: BoxFit.cover,
                )
              else
                Image.asset('assets/images/placeholder.png'),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      VoteAverageMovie(
                        movie: movie,
                        fontSizeText: 24.0,
                        sizeIcon: 44.0,
                      ),
                      VoteCountMovie(
                        movie: movie,
                        fontSizeText: 24.0,
                        sizeIcon: 44.0,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                movie.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                  onPressed: () {
                    favoritesProvider.toggleFavorite(movie);
                  },
                  icon: Icon(
                    favoritesProvider.isFavorite(movie)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favoritesProvider.isFavorite(movie)
                        ? Colors.red
                        : Colors.grey,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
