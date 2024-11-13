import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
