// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

class KuvariApp extends StatefulWidget {
  const KuvariApp({Key? key}) : super(key: key);

  @override
  _KuvariAppState createState() => _KuvariAppState();
}

class _KuvariAppState extends State<KuvariApp> {
  Locale _locale = const Locale('fi');

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final kuvariService = KuvariService();

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      locale: _locale,
      supportedLocales: const [
        Locale('fi'),
        Locale('sv'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomePage(
        kuvariService: kuvariService,
        setLocale: _setLocale,
      ),
    );
  }
}
