import 'package:flutter/material.dart';
import 'package:movies_app/screens/movie_details_screen.dart';
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
  final apiService = ApiServices();
  List<Movie> _movies = [];
  String beforeQuery = '';
  String query = '';
  int currentPage = 1;
  bool isLoading = false;

  String? selectedGenre;
  String? selectedYear;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    loadMovies();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isLoading &&
        currentPage <= apiService.totalPages) {
      print("Cargando mas peliculas... Pagina: $currentPage");
      loadMovies(); // Cargar más películas al final de la lista
    }
  }

  void _searchMovies() async {
    setState(() => query = _controller.text);
    currentPage = 1;
    setState(() => _movies = []);
    loadMovies();
    _scrollController.jumpTo(0);
    beforeQuery = query;
  }

  void loadMovies() async {
    if (isLoading && currentPage > 1) return;
    setState(() {
      isLoading = true;
      query = _controller.text;
    });

    if (query.isNotEmpty) {
      print("QUERY: $query");
      try {
        var movies = await apiService.searchMovieWithFilters(
          query,
          genre: selectedGenre,
          year: selectedYear,
          page: currentPage,
        );
        // }
        setState(() {
          _movies.addAll(movies);
          currentPage++;
        });
      } catch (error) {
        print("Error al cargar películas: $error");
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  hint: const Text('Género'),
                  value: selectedGenre,
                  items:
                      <String>['Accion', 'Drama', 'Comedy'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedGenre = value;
                    });
                  },
                ),
                DropdownButton<String>(
                  hint: const Text('Año'),
                  value: selectedYear,
                  items: <String>['2022', '2021', '2020'] // Ejemplo de años
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedYear = null;
                      selectedGenre = null;
                    });
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30.0,
                  ),
                )
              ],
            ),
            ElevatedButton.icon(
              onPressed: _searchMovies,
              icon: const Icon(
                Icons.search,
                color: Colors.blue,
                size: 30.0,
              ),
              label: const Text('Buscar'),
            ),
            Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _movies.length + 1,
                    itemBuilder: (context, index) {
                      if (_movies.isEmpty) return null;
                      if (index == _movies.length) {
                        return isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : const SizedBox();
                      }
                      final movie = _movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsScreen(
                                movie: movie,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
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
                                    title: movie.title,
                                    description: movie.description,
                                    voteAverage:
                                        movie.voteAverage.toStringAsFixed(1),
                                    voteCount:
                                        movie.voteCount.toStringAsFixed(1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
