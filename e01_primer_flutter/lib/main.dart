import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    // Material App
    return MaterialApp(
        // Scaffold Widget
        home: Scaffold(
      body: const Center(child: Text('Hello World')),
    ));
  }
}


