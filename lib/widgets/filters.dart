import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FiltersState();
  }
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton.new(
          hint: const Text('Selecciona el género'),
          items: <String>['Accion', 'Drama', 'Comedy'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              // selectedGenre = value;
            });
          },
        )
      ],
    );
  }
}
