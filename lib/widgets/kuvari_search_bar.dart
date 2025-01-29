// lib/widgets/kuvari_search_bar.dart

import 'package:flutter/material.dart';

class KuvariSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  const KuvariSearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, TextEditingValue value, child) {
              return TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => onSearch(),
                decoration: InputDecoration(
                  labelText: 'Hae kuvalla esim. hymy',
                  border: const OutlineInputBorder(),
                  suffixIcon: value.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: onClear,
                          tooltip: 'Tyhjennä hakukenttä',
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
          onPressed: onSearch,
          child: const Icon(Icons.search),
        ),
      ],
    );
  }
}
