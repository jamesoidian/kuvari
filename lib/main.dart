// lib/main.dart

import 'dart:async';  
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/pages/home_page.dart';
import 'package:kuvari_app/services/kuvari_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configure Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(ImageStoryAdapter());
  Hive.registerAdapter(KuvariImageAdapter());

  // Open database box
  await Hive.openBox<ImageStory>('imageStories');

  // Run app with error handling
  runZonedGuarded<Future<void>>(() async {
    runApp(const KuvariApp());
  }, FirebaseCrashlytics.instance.recordError);
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
