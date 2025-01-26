// lib/main.dart

import 'package:flutter/material.dart';
import 'package:tarinappi/pages/home_page.dart';

void main() {
  runApp(const KuhaApp());
}

class KuhaApp extends StatelessWidget {
  const KuhaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuha App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // Poistaa debug-bannerin
    );
  }
}
