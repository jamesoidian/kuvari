// lib/widgets/kuvari_search_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KuvariSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onClear;
  final VoidCallback onTap; // Lisätään taputuskäsittelijä

  const KuvariSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
    required this.onTap, // Lisätään taputuskäsittelijä
  });

  @override
  State<KuvariSearchBar> createState() => _KuvariSearchBarState();
}

class _KuvariSearchBarState extends State<KuvariSearchBar> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        widget.onTap(); // Kutsutaan taputuskäsittelijää kun kenttä saa fokuksen
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: widget.controller,
            builder: (context, TextEditingValue value, child) {
              return TextField(
                focusNode: _focusNode, // Määritetään FocusNode
                controller: widget.controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => widget.onSearch(),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.searchHint,
                  border: const OutlineInputBorder(),
                  suffixIcon: value.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: widget.onClear,
                          tooltip: AppLocalizations.of(context)!.clear,
                        )
                      : null,
                ),
                onChanged: (_) {}, // Tarvitaan UI:n päivitykseen
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: widget.onSearch,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shadowColor: Colors.tealAccent,
          ),
          child: const Icon(
            Icons.search_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
