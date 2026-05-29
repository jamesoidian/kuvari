# Phase 3 Summary: UI Integration

## Completed Tasks
- **Instantiate TtsService**: Added `TtsService` instantiation to `_HomePageState` in `lib/pages/home_page.dart` and passed it down to `ImageGrid`.
- **Add speaker icon to ImageGrid**: Modified `lib/widgets/image_grid.dart` to add a speaker icon (`IconButton` with `Icons.volume_up`) next to the image name. Tapping it calls `ttsService.speak` with the image name and the current UI locale.

## Changes Made
- Modified `lib/pages/home_page.dart`.
- Modified `lib/widgets/image_grid.dart`.

All tasks completed successfully.
