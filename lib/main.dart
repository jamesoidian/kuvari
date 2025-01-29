// lib/main.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/pages/home_page.dart';
import 'package:kuvari_app/services/kuvari_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Alusta Hive
  await Hive.initFlutter();

  // Rekisteröi Hive-adapterit
  Hive.registerAdapter(ImageStoryAdapter());
  Hive.registerAdapter(KuvariImageAdapter());

  // Avaa tietokantaboxi
  await Hive.openBox<ImageStory>('imageStories');

  runApp(const KuvariApp());
}

class KuvariApp extends StatelessWidget {
  const KuvariApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Luo instanssi KuvariServicea
    final kuvariService = KuvariService();

    return MaterialApp(
      title: 'Kuvari',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(kuvariService: kuvariService),
    );
  }
}
