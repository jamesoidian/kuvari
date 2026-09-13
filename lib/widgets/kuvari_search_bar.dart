// lib/widgets/kuvari_search_bar.dart

import 'package:flutter/material.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';

class KuvariSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onClear;
  final VoidCallback onTap; // Lisätään taputuskäsittelijä
  final FocusNode? focusNode;

  const KuvariSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
    required this.onTap, // Lisätään taputuskäsittelijä
    this.focusNode,
  });

  @override
  State<KuvariSearchBar> createState() => _KuvariSearchBarState();
}

class _KuvariSearchBarState extends State<KuvariSearchBar> {
  FocusNode? _internalFocusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode!;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }

    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_effectiveFocusNode.hasFocus) {
      widget.onTap(); // Kutsutaan taputuskäsittelijää kun kenttä saa fokuksen
    }
  }

  @override
  void didUpdateWidget(covariant KuvariSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      (oldWidget.focusNode ?? _internalFocusNode)?.removeListener(_handleFocusChange);
      if (widget.focusNode != null) {
        _internalFocusNode?.dispose();
        _internalFocusNode = null;
      } else {
        _internalFocusNode ??= FocusNode();
      }
      _effectiveFocusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChange);
    _internalFocusNode?.dispose();
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
                focusNode: _effectiveFocusNode, // Määritetään FocusNode
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
