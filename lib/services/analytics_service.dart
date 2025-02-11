import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics;

  AnalyticsService(this._analytics);

  Future<void> logSearch(String query, String languageCode) async {
    await _analytics.logEvent(
      name: 'search',
      parameters: {
        'query': query,
        'language': languageCode,
      },
    );
  }

  Future<void> logSaveImageStory(String storyName, int imageCount) async {
    await _analytics.logEvent(
      name: 'save_image_story',
      parameters: {
        'story_name': storyName,
        'image_count': imageCount,
      },
    );
  }

  Future<void> logViewImageStory(int imageCount, String source) async {
    await _analytics.logEvent(
      name: 'view_image_story',
      parameters: {
        'image_count': imageCount,
        'source': source,
      },
    );
  }

  Future<void> logViewInfoPage() async {
    await _analytics.logEvent(name: 'view_info_page');
  }
}
