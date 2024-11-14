import 'package:flutter/material.dart';

class MovieDescription extends StatelessWidget {
  const MovieDescription({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

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
          ),
        ],
      ),
    );
  }
}
