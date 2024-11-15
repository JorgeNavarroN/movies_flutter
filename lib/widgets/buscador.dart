import 'package:flutter/material.dart';
import 'package:movies_app/services/open_filters_services.dart';

class Buscador extends StatelessWidget {
  final TextEditingController controller;
  final Function({String? genre, double? minCalif, int? year}) searchFunction;

  const Buscador({
    super.key,
    required this.controller,
    required this.searchFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Buscar película',
              border: const OutlineInputBorder(),
              icon: IconButton(
                onPressed: searchFunction,
                icon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () => openFilterDialog(context, searchFunction),
          icon: const Icon(Icons.filter_list),
        ),
      ],
    );
  }
}
