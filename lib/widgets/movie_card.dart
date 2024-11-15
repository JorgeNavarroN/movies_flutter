import 'package:flutter/material.dart';
import 'package:movies_app/widgets/movie_description.dart';

class MovieCard extends StatelessWidget {
  final dynamic movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
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
                movie: movie,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
