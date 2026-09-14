// lib/widgets/edit_mode_banner.dart

import 'package:flutter/material.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';

class EditModeBanner extends StatelessWidget {
  final String storyName;
  final VoidCallback onSave;
  final VoidCallback onStop;

  const EditModeBanner({
    super.key,
    required this.storyName,
    required this.onSave,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.amber.shade300, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.edit, color: Colors.amber.shade900, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l10n.editModeBannerTitle(storyName),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade900,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
            ),
            icon: const Icon(Icons.save, size: 16),
            label: Text(l10n.save, style: const TextStyle(fontSize: 13)),
            onPressed: onSave,
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(Icons.close, color: Colors.grey.shade700, size: 20),
            tooltip: l10n.stopEditing,
            onPressed: onStop,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
