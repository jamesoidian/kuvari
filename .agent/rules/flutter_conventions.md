# Flutter and Dart Conventions

This rule ensures consistency in Flutter and Dart development within the Kuvari project.

## Activation
- Always on for `.dart` files.

## Guidelines

- **Localization**: Always use `AppLocalizations` for user-facing strings.
    - Good: `Text(AppLocalizations.of(context)!.search)`
    - Bad: `Text('Search')`
- **Widget Composition**: Prefer composition over inheritance. Break down complex widgets into smaller, reusable components.
- **Image Display**: Use the `KuvariImageDisplay` widget for consistent image rendering across the app.
- **Naming**: Follow standard Dart naming conventions (PascalCase for classes, camelCase for variables/functions).
