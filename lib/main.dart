import 'package:flutter/material.dart';
import 'package:movies_app/providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MovieApp(),
    ),
  );
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
      home: const MainScreen(),
    );
  }
}
