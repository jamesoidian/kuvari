import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategorySelectionDialog extends StatefulWidget {
  final List<String> selectedCategories;

  const CategorySelectionDialog({Key? key, required this.selectedCategories}) : super(key: key);

  @override
  _CategorySelectionDialogState createState() => _CategorySelectionDialogState();
}

class _CategorySelectionDialogState extends State<CategorySelectionDialog> {
  late Map<String, String> categories;

  @override
  void initState() {
    super.initState();
    _selected = {};
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categories = {
      'arasaac': AppLocalizations.of(context)!.categoryArasaac,
      'kuvako': AppLocalizations.of(context)!.categoryKuvako,
      'mulberry': AppLocalizations.of(context)!.categoryMulberry,
      'drawing': AppLocalizations.of(context)!.categoryDrawing,
      'sclera': AppLocalizations.of(context)!.categorySclera,
      'toisto': AppLocalizations.of(context)!.categoryToisto,
      'photo': AppLocalizations.of(context)!.categoryPhoto,
      'sign': AppLocalizations.of(context)!.categorySign,
    };
    categories.forEach((key, value) {
      _selected[key] = widget.selectedCategories.contains(key);
    });
  }

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
      title: Text(AppLocalizations.of(context)!.selectCategories),
      content: SingleChildScrollView(
        child: Column(
          children: categories.entries.map((entry) {
            return CheckboxListTile(
              title: Text(entry.value),
              value: _selected[entry.key],
              onChanged: (bool? value) {
                if (value == false && _selected.values.where((isSelected) => isSelected).length <= 1) {
                  // Estetään viimeisen valinnan poistaminen
                  return;
                }
                setState(() {
                  _selected[entry.key] = value!;
                });
              },
              // Estetään poiskytkeminen, jos vain yksi kategoria on valittuna
              enabled: _selected.values.where((isSelected) => isSelected).length > 1 || _selected[entry.key] == false,
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Suljetaan dialogi ilman muutoksia
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final selectedCategories = _selected.entries
                .where((entry) => entry.value)
                .map((entry) => entry.key)
                .toList();

            Navigator.of(context).pop(selectedCategories); // Palautetaan valitut kategoriat
          },
          child: Text(AppLocalizations.of(context)!.ok),
        ),
      ],
    );
  }
}
