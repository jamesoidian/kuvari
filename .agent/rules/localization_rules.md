# Localization Guidelines

Ensures the project remains fully localized and accessible in multiple languages.

## Activation
- Activates when working with `.arb` files or user-facing UI code.

## Guidelines

- **Supported Languages**: Always maintain support for Finnish (`fi`), Swedish (`sv`), and English (`en`).
- **ARB Files**: New strings must be added to `lib/l10n/app_fi.arb`, `lib/l10n/intl_sv.arb` (ensure naming consistency), and English equivalents.
- **Dynamic Content**: Use placeholders in ARB files for dynamic data.
- **Testing**: Verify that new UI elements adapt correctly to different string lengths across languages.
