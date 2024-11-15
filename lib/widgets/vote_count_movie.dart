import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';

class VoteCountMovie extends StatelessWidget {
  final Movie movie;
  final double fontSizeText;
  final double sizeIcon;

  const VoteCountMovie({
    super.key,
    required this.movie,
    this.fontSizeText = 18,
    this.sizeIcon = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.people,
              color: Colors.teal,
              size: sizeIcon,
            ),
            Text(
              movie.voteCount.toStringAsFixed(1),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSizeText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
