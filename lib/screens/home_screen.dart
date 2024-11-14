import 'package:flutter/material.dart';
import 'package:movies_app/services/api_services.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/movie_description.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Movie> _movies = [];

  void _searchMovie() async {
    final query = _controller.text;
    if (query.isNotEmpty) {
      final apiService = ApiServices();
      var movies = await apiService.searchMovie(query);
      setState(() {
        _movies = movies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Buscar película',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _searchMovie,
              child: const Text('Buscar'),
            ),
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              if (_movies.isEmpty) return null;
              if (index >= _movies.length) return null;
              final movie = _movies[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: movie.posterPath != ''
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}')
                        : Image.asset('assets/images/placeholder.png'),
                  ),
                  Expanded(
                    flex: 3,
                    child: MovieDescription(
                      title: movie.title,
                      description: movie.description,
                    ),
                  )
                ],
              );
            }))
          ],
        ),
      ),
    );
  }
}
