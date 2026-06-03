# Milestone Audit: Text-to-Speech

**Audited:** 2026-06-03

## Summary
| Metric | Value |
|--------|-------|
| Phases | 4 |
| Gap closures | 0 |
| Technical debt items | 0 |

## Must-Haves Status
| Requirement | Verified | Evidence |
|-------------|----------|----------|
| Add TTS Package | ✅ | pubspec.yaml updated with flutter_tts |
| Ensure Configuration | ✅ | AndroidManifest.xml updated with TTS_SERVICE |
| Create TTS Service | ✅ | TtsService class present in tts_service.dart |
| Update UI | ✅ | IconButton with Icons.volume_up present in image_grid.dart and image_viewer_page.dart |

## Concerns
- The iOS Simulator's audio engine can occasionally clash with macOS `coreaudiod` causing crackling audio across the host machine.
- Firebase Crashlytics build scripts (`upload-symbols`) can fail on simulator debug builds if dSYM generation isn't explicitly configured.

## Recommendations
1. Test the Text-to-Speech playback extensively on physical Android and iOS devices, as the iOS simulator's audio engine can produce hardware-specific artifacts that don't represent real-world use.
2. Consider adding an option to globally toggle TTS off in a future Settings screen if users find it disruptive in quiet environments.

## Technical Debt to Address
- [ ] No specific technical debt generated during this milestone.
