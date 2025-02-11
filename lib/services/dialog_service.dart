import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kuvari_app/models/kuvari_image.dart';

class DialogService {
  static Future<String?> showSaveImageStoryDialog(
    BuildContext context,
  ) async {
    final storyNameController = TextEditingController();
    
    try {
      final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.saveImageStory),
            content: TextField(
              controller: storyNameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.giveImageStoryName,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = storyNameController.text.trim();
                  if (name.isNotEmpty) {
                    Navigator.of(context).pop(name);
                  }
                },
                child: Text(AppLocalizations.of(context)!.save),
              ),
            ],
          );
        },
      );
      
      return result?.trim();
    } finally {
      storyNameController.dispose();
    }
  }

  static Future<bool> showClearImagesDialog(
    BuildContext context,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.clearImageStory),
          content: Text(AppLocalizations.of(context)!.emptySelectedImagesConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(AppLocalizations.of(context)!.clear),
            ),
          ],
        );
      },
    );
    
    return result ?? false;
  }
}
