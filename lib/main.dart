// lib/main.dart

import 'package:flutter/material.dart';
import 'package:kuha_app/pages/home_page.dart';

void main() {
  runApp(const KuhaApp());
}

class KuhaApp extends StatelessWidget {
  const KuhaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuvari',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true, // Ota käyttöön Material 3
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          shadowColor: Colors.tealAccent,
          elevation: 6.0,
        ),
      ),
      home: const HomePage(),
    );
  }
}
