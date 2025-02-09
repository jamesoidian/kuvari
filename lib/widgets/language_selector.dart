import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final Locale currentLocale;
  final Function(Locale) onLocaleChange;

  const LanguageSelector({
    Key? key,
    required this.currentLocale,
    required this.onLocaleChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: currentLocale,
      icon: const Icon(Icons.language, color: Colors.white),
      underline: const SizedBox(),
      dropdownColor: Colors.teal,
      items: const [
        DropdownMenuItem(
          value: Locale('fi'),
          child: Text('FI', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: Locale('sv'),
          child: Text('SE', style: TextStyle(color: Colors.white)),
        ),
      ],
      onChanged: (Locale? locale) {
        if (locale != null) {
          onLocaleChange(locale);
        }
      },
    );
  }
}
