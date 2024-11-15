import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String posterPath;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final int voteCount;

  @HiveField(5)
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.description,
    required this.voteCount,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Sin titulo',
      posterPath: json['poster_path'] ?? '',
      description: json['overview'] ?? 'Sin descripción',
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
    );
  }
}
