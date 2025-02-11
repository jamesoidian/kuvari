import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics;
  
  const AnalyticsService(this._analytics);

  static AnalyticsService? _instance;
  
  static AnalyticsService get instance {
    if (_instance == null) {
      _instance = AnalyticsService(FirebaseAnalytics.instance);
    }
    return _instance!;
  }

  Future<void> logSearch(String query, String languageCode) async {
    await _analytics.logEvent(
      name: 'search',
      parameters: {
        'query': query,
        'language': languageCode,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> logSaveImageStory(String storyName, int imageCount) async {
    await _analytics.logEvent(
      name: 'save_image_story',
      parameters: {
        'story_name': storyName,
        'image_count': imageCount,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> logViewImageStory(int imageCount, String source) async {
    await _analytics.logEvent(
      name: 'view_image_story',
      parameters: {
        'image_count': imageCount,
        'source': source,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> logViewInfoPage() async {
    await _analytics.logEvent(
      name: 'view_info_page',
      parameters: {
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> logError(String errorCode, String errorMessage) async {
    await _analytics.logEvent(
      name: 'app_error',
      parameters: {
        'error_code': errorCode,
        'error_message': errorMessage,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
}
