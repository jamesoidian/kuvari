// lib/widgets/image_grid.dart

import 'package:flutter/material.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/widgets/kuvari_image_display.dart';
import 'package:kuvari_app/services/tts_service.dart';

class ImageGrid extends StatelessWidget {
  final List<KuvariImage> images;
  final List<KuvariImage> selectedImages;
  final Function(KuvariImage) onSelect;
  final TtsService ttsService;

  const ImageGrid({
    super.key,
    required this.images,
    required this.selectedImages,
    required this.onSelect,
    required this.ttsService,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final crossAxisCount = orientation == Orientation.landscape ? 4 : 2;

    return images.isEmpty
        ? Center(child: Text(AppLocalizations.of(context)!.noResults))
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.8,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final img = images[index];
              final isSelected = selectedImages.contains(img);
              return GestureDetector(
                onTap: () => onSelect(img),
                child: Stack(
                  children: [
                    Card(
                      elevation: 2,
                      child: Column(
                        children: [
                          Expanded(
                            child: KuvariImageDisplay(
                              url: img.thumb,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorWidget: const Icon(Icons.broken_image),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    img.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.volume_up, size: 20, color: Colors.teal),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    ttsService.speak(img.name, Localizations.localeOf(context).languageCode);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Icon(Icons.check_circle, color: Colors.green[700]),
                      ),
                  ],
                ),
              );
            },
          );
  }
}
