import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';

class VoteAverageMovie extends StatelessWidget {
  final Movie movie;
  final double fontSizeText;
  final double sizeIcon;

  const VoteAverageMovie({
    super.key,
    required this.movie,
    this.fontSizeText = 18,
    this.sizeIcon = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: sizeIcon,
        ),
        Text(
          movie.voteAverage.toStringAsFixed(1),
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: fontSizeText),
        ),
        Text(
          "/10",
          style: TextStyle(fontSize: fontSizeText),
        ),
      ],
    );
  }
}
