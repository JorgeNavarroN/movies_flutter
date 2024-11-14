class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String description;
  final int voteCount;
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
