import 'package:flutter/material.dart';
import 'package:movies_app/screens/movie_details_screen.dart';
import 'package:movies_app/services/api_services.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/movie_description.dart';
import 'package:movies_app/widgets/bottom_sheet.dart';

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

  void _searchMovies({String? genre, int? year, double? minCalif}) async {
    setState(() {
      query = _controller.text;
      currentPage = 1;
      _movies = [];
    });
    loadMovies(genre: genre, year: year, minCalif: minCalif);
    _scrollController.jumpTo(0);
    beforeQuery = query;
  }

  void loadMovies({String? genre, int? year, double? minCalif}) async {
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
          genre: genre,
          minRating: minCalif,
          year: year,
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

  void _openFilterDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Filters(onPress: _searchMovies);
        });
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Buscar película',
                      border: const OutlineInputBorder(),
                      icon: IconButton(
                        onPressed: _searchMovies,
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _openFilterDialog(context),
                  icon: const Icon(Icons.filter_list),
                ),
              ],
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
