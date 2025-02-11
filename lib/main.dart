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
import 'package:firebase_analytics/firebase_analytics.dart';
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
  const KuvariApp({super.key});

  @override
  State<KuvariApp> createState() => _KuvariAppState();
}

class _KuvariAppState extends State<KuvariApp> {
  Locale _locale = const Locale('fi');
  late FirebaseAnalytics analytics;
  late FirebaseAnalyticsObserver observer;

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final kuvariService = KuvariService();

    return MaterialApp(
      navigatorObservers: [observer],
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
        analytics: analytics,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    analytics = FirebaseAnalytics.instance;
    observer = FirebaseAnalyticsObserver(analytics: analytics);
  }
}
