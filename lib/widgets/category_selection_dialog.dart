
import 'package:flutter/material.dart';

class CategorySelectionDialog extends StatefulWidget {
  final List<String> selectedCategories;

  const CategorySelectionDialog({Key? key, required this.selectedCategories}) : super(key: key);

  @override
  _CategorySelectionDialogState createState() => _CategorySelectionDialogState();
}

class _CategorySelectionDialogState extends State<CategorySelectionDialog> {
  final Map<String, String> categories = {
    'arasaac': 'Arasaac',
    'kuvako': 'KUVAKO',
    'mulberry': 'Mulberry',
    'drawing': 'Piirroskuva',
    'sclera': 'Sclera',
    'toisto': 'Toisto',
    'photo': 'Valokuva',
    'sign': 'Viittoma',
  };

  late Map<String, bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = {};
    categories.forEach((key, value) {
      _selected[key] = widget.selectedCategories.contains(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Valitse kategoriat'),
      content: SingleChildScrollView(
        child: Column(
          children: categories.entries.map((entry) {
            return CheckboxListTile(
              title: Text(entry.value),
              value: _selected[entry.key],
              onChanged: (bool? value) {
                setState(() {
                  _selected[entry.key] = value!;
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Suljetaan dialogi ilman muutoksia
          },
          child: const Text('Peruuta'),
        ),
        ElevatedButton(
          onPressed: () {
            final selectedCategories = _selected.entries
                .where((entry) => entry.value)
                .map((entry) => entry.key)
                .toList();

            Navigator.of(context).pop(selectedCategories); // Palautetaan valitut kategoriat
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
