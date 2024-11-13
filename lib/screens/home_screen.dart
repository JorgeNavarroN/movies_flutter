import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: const Center(
        child: Text(
          'Bienvenido a la App de Películas',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
