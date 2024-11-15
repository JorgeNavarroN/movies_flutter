import 'package:flutter/material.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/screens/movie_details_screen.dart';
import 'package:movies_app/services/api_services.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/buscador.dart';
import 'package:movies_app/widgets/movie_card.dart';

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
  String query = '';
  int currentPage = 1;
  bool isLoading = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // loadMovies();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isLoading &&
        currentPage <= apiService.totalPages) {
      loadMovies();
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
  }

  void loadMovies({String? genre, int? year, double? minCalif}) async {
    if (isLoading && currentPage > 1) return;
    if (query.isNotEmpty) {
      setState(() {
        isLoading = true;
        query = _controller.text;
      });
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
        dialogService.showAlert("Error al cargar películas: $error");
      } finally {
        setState(() => isLoading = false);
      }
    } else {
      dialogService.showAlert("El campo está vació. Rellene el campo.");
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
            Buscador(controller: _controller, searchFunction: _searchMovies),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _movies.length + 1,
                itemBuilder: (context, index) {
                  if (_movies.isEmpty) {
                    return isLoading
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const Center(
                            child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Text(
                              'No hay películas a mostrar',
                              textAlign: TextAlign.center,
                            ),
                          ));
                  }
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
                    child: MovieCard(
                      movie: movie,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
