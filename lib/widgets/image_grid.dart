// lib/widgets/image_grid.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kuvari_app/models/kuvari_image.dart';

class ImageGrid extends StatelessWidget {
  final List<KuvariImage> images;
  final List<KuvariImage> selectedImages;
  final Function(KuvariImage) onSelect;

  const ImageGrid({
    super.key,
    required this.images,
    required this.selectedImages,
    required this.onSelect,
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
                            child: Image.network(
                              img.thumb,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              img.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
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
