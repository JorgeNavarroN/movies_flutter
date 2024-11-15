import 'package:flutter/material.dart';
import 'package:movies_app/widgets/filters.dart';

void openFilterDialog(
  BuildContext context,
  dynamic Function({String? genre, double? minCalif, int? year}) searchMovies,
) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Filters(onPress: searchMovies);
      });
}
