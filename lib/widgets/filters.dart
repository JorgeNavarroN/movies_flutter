import 'package:flutter/material.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/services/api_services.dart';

class Filters extends StatefulWidget {
  final Function({String? genre, double? minCalif, int? year}) onPress;

  const Filters({super.key, required this.onPress});

  @override
  State<StatefulWidget> createState() {
    return _Filters();
  }
}

class _Filters extends State<Filters> {
  final _apiService = ApiServices();
  String? selectedGenre;
  int? selectedYear;
  double selectedMinCalif = 0.0;
  List<Genre> _genres = [];

  @override
  void initState() {
    super.initState();
    _loadGenres();
  }

  void _loadGenres() async {
    final genres = await _apiService.getGenresMovies();
    setState(() {
      _genres = genres;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filtrar películas',
            style: TextStyle(fontSize: 18),
          ),
          DropdownButtonFormField<int>(
            hint: const Text('Año'),
            items: List.generate(50, (index) {
              int year = DateTime.now().year - index;
              return DropdownMenuItem(
                value: year,
                child: Text(year.toString()),
              );
            }),
            onChanged: (int? value) {
              setState(() {
                selectedYear = value;
              });
            },
          ),
          DropdownButtonFormField<String>(
            hint: const Text('Género'),
            value: selectedGenre,
            items: _genres.map((genre) {
              return DropdownMenuItem(
                value: genre.name,
                child: Text(genre.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedGenre = value;
              });
            },
          ),
          Row(
            children: [
              const Text(
                "Min. Calificación: ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                  color: Color.fromARGB(255, 109, 109, 109),
                ),
              ),
              Expanded(
                child: Slider(
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: selectedMinCalif.toString(),
                  onChanged: (value) {
                    setState(() {
                      selectedMinCalif = value;
                    });
                  },
                  value: selectedMinCalif,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              widget.onPress(
                genre: selectedGenre,
                year: selectedYear,
                minCalif: selectedMinCalif,
              );
              Navigator.pop(context);
            },
            child: const Text('Aplicar filtros'),
          )
        ],
      ),
    );
  }
}
