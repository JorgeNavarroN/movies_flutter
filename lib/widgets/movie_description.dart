import 'package:flutter/material.dart';

class MovieDescription extends StatelessWidget {
  const MovieDescription({
    super.key,
    required this.title,
    required this.description,
    required this.voteAverage,
    required this.voteCount,
  });

  final String title;
  final String description;
  final String voteAverage;
  final String voteCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            description,
            style: const TextStyle(fontSize: 12.0),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 30.0,
              ),
              Text(
                voteAverage,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
              const Text(
                "/10",
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
