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

 void main() {                                                                                                                              
   runZonedGuarded<Future<void>>(() async {                                                                                                 
     // Varmistetaan, että WidgetsBinding on alustettu tässä zonessa                                                                        
     WidgetsFlutterBinding.ensureInitialized();                                                                                             
                                                                                                                                            
     // Alustetaan Firebase                                                                                                                 
     await Firebase.initializeApp(                                                                                                          
       options: DefaultFirebaseOptions.currentPlatform,                                                                                     
     );                                                                                                                                     
                                                                                                                                            
     // Asetetaan Crashlyticsin virheenkäsittelijä nyt, kun Firebase on alustettu                                                           
     FlutterError.onError =                                                                                                                 
         FirebaseCrashlytics.instance.recordFlutterFatalError;                                                                              
                                                                                                                                            
     // Alustetaan Hive                                                                                                                     
     await Hive.initFlutter();                                                                                                              
                                                                                                                                            
     // Rekisteröidään Hive-adapterit ennen kuin avataan laatikot                                                                           
     Hive.registerAdapter(ImageStoryAdapter());                                                                                             
     Hive.registerAdapter(KuvariImageAdapter());                                                                                            
                                                                                                                                            
     // Avataan Hive-laatikot                                                                                                               
     await Hive.openBox<ImageStory>('imageStories');                                                                                        
                                                                                                                                            
     // Alustetaan Firebase Analytics                                                                                                       
     final analytics = FirebaseAnalytics.instance;                                                                                          
     final observer = FirebaseAnalyticsObserver(analytics: analytics);                                                                      
                                                                                                                                            
     // Ajetaan sovellus                                                                                                                    
     runApp(KuvariApp(                                                                                                                      
       analytics: analytics,                                                                                                                
       observer: observer,                                                                                                                  
     ));                                                                                                                                    
   }, (error, stackTrace) {                                                                                                                 
     // Käsitellään virheet Crashlyticsin avulla                                                                                            
     FirebaseCrashlytics.instance.recordError(error, stackTrace);                                                                           
   });                                                                                                                                      
 }  

class KuvariApp extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  const KuvariApp({
    super.key,
    required this.analytics,
    required this.observer,
  });

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
