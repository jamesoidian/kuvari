// lib/main.dart

import 'package:flutter/material.dart';
import 'package:kuha_app/pages/home_page.dart';
import 'package:kuha_app/services/kuha_service.dart';

void main() {
  runApp(const KuvariApp());
}

class KuvariApp extends StatelessWidget {
  const KuvariApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Luo instanssi KuhaServicea
    final kuhaService = KuhaService();

    return MaterialApp(
      title: 'Kuvari',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(kuhaService: kuhaService),
    );
  }
}
