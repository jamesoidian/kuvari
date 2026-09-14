// lib/widgets/edit_mode_save_dialog.dart

import 'package:flutter/material.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';

sealed class EditModeSaveResult {
  const EditModeSaveResult();
}

class UpdateExistingStoryResult extends EditModeSaveResult {
  const UpdateExistingStoryResult();
}

class SaveAsNewStoryResult extends EditModeSaveResult {
  final String name;
  const SaveAsNewStoryResult(this.name);
}

class EditModeSaveDialog extends StatefulWidget {
  final String storyName;

  const EditModeSaveDialog({
    super.key,
    required this.storyName,
  });

  @override
  State<EditModeSaveDialog> createState() => _EditModeSaveDialogState();
}

class _EditModeSaveDialogState extends State<EditModeSaveDialog> {
  bool _isNamingNew = false;
  late final TextEditingController _nameController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final l10n = AppLocalizations.of(context)!;
      final defaultNewName = l10n.storyCopySuffix(widget.storyName);
      _nameController.text = defaultNewName;
      _nameController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: defaultNewName.length,
      );
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isNamingNew) {
      return AlertDialog(
        title: Text(l10n.saveAsNewStoryTitle),
        content: TextField(
          controller: _nameController,
          autofocus: true,
          decoration: InputDecoration(
            labelText: l10n.giveImageStoryName,
          ),
          onChanged: (_) => setState(() {}),
          onSubmitted: (text) {
            final trimmed = text.trim();
            if (trimmed.isNotEmpty) {
              Navigator.of(context).pop(SaveAsNewStoryResult(trimmed));
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() => _isNamingNew = false),
            child: Text(l10n.back),
          ),
          ElevatedButton(
            onPressed: _nameController.text.trim().isEmpty
                ? null
                : () {
                    final trimmed = _nameController.text.trim();
                    if (trimmed.isNotEmpty) {
                      Navigator.of(context).pop(SaveAsNewStoryResult(trimmed));
                    }
                  },
            child: Text(l10n.save),
          ),
        ],
      );
    }

    return AlertDialog(
      title: Text(l10n.saveImageStory),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.update, color: Colors.teal, size: 24),
                ),
                title: Text(
                  l10n.updateExistingStory(widget.storyName),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(l10n.updateExistingStoryDescription),
                onTap: () {
                  Navigator.of(context).pop(const UpdateExistingStoryResult());
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.bookmark_add_outlined,
                      color: Colors.teal, size: 24),
                ),
                title: Text(
                  l10n.saveAsNewStory,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(l10n.saveAsNewStoryDescription),
                onTap: () {
                  setState(() {
                    _isNamingNew = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }
}
