class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String description;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.description,
  })

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      description: json['overview'],
    );
  }
}