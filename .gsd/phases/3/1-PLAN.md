---
phase: 3
plan: 1
wave: 1
---

# Plan 3.1: UI Integration

## Objective
Add a speaker icon button to image cards and connect it to the TTS service.

## Context
- lib/pages/home_page.dart
- lib/widgets/image_grid.dart
- lib/services/tts_service.dart

## Tasks

<task type="auto">
  <name>Instantiate TtsService</name>
  <files>lib/pages/home_page.dart, lib/widgets/image_grid.dart</files>
  <action>
    - In `lib/pages/home_page.dart`, instantiate `TtsService` in `_HomePageState` (`final _ttsService = TtsService();`).
    - Pass `_ttsService` down to `ImageGrid` in the `build` method.
    - In `lib/widgets/image_grid.dart`, update the `ImageGrid` constructor to accept `final TtsService ttsService;`.
  </action>
  <verify>grep -q "ttsService" lib/widgets/image_grid.dart</verify>
  <done>TtsService is instantiated in HomePage and passed to ImageGrid.</done>
</task>

<task type="auto">
  <name>Add speaker icon to ImageGrid</name>
  <files>lib/widgets/image_grid.dart</files>
  <action>
    - In `ImageGrid`, locate the `Text(img.name)` inside the `Padding`.
    - Wrap the `Text` in an `Expanded` widget and put it inside a `Row`.
    - Add an `IconButton` to the `Row` with `Icon(Icons.volume_up)`.
    - Set the `onPressed` of the `IconButton` to call `ttsService.speak(img.name, Localizations.localeOf(context).languageCode)`.
  </action>
  <verify>grep -q "Icons.volume_up" lib/widgets/image_grid.dart</verify>
  <done>Speaker icon is present and connected to ttsService.</done>
</task>

## Success Criteria
- [ ] Speaker icon appears next to the image name in the grid.
- [ ] Tapping the icon calls the TTS service to speak the word.
