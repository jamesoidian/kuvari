# Milestone: Text-to-Speech

## Completed: 2026-06-03

## Deliverables
- ✅ Add TTS Package
- ✅ Ensure Configuration
- ✅ Create TTS Service
- ✅ Update UI

## Phases Completed
1. Phase 1: Setup & Configuration
2. Phase 2: Service Layer
3. Phase 3: UI Integration
4. Phase 4: Testing & Polish

## Metrics
- Total phases: 4
- Core files modified: `pubspec.yaml`, `AndroidManifest.xml`, `tts_service.dart`, `image_grid.dart`, `home_page.dart`, `image_viewer_page.dart`, `ios/Podfile`, `project.pbxproj`

## Lessons Learned
- Handling Xcode 16 Swift 6 strict concurrency errors requires modifying the `Podfile` to suppress warnings for generated plugins.
- Firebase Crashlytics scripts require `dwarf-with-dsym` configuration on Debug Simulator builds to not crash during `upload-symbols`.
- `flutter_tts` requires specific Android 11+ `<queries>` intents in `AndroidManifest.xml`.
