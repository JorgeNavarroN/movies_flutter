import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/vote_average_movie.dart';

class MovieDescription extends StatelessWidget {
  final Movie movie;

  const MovieDescription({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            movie.title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            movie.description,
            style: const TextStyle(fontSize: 12.0),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          VoteAverageMovie(movie: movie)
        ],
      ),
    );
  }
}
