// lib/widgets/selected_images_carousel.dart

import 'package:flutter/material.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectedImagesCarousel extends StatelessWidget {
  final List<KuvariImage> selectedImages;
  final int currentStartIndex;
  final int maxVisibleImages;
  final VoidCallback onScrollLeft;
  final VoidCallback onScrollRight;
  final VoidCallback onClear;
  final Function(int) onRemove;
  final Function(int, int) onReorder;
  final bool showClearButton;

  const SelectedImagesCarousel({
    Key? key,
    required this.selectedImages,
    required this.currentStartIndex,
    required this.maxVisibleImages,
    required this.onScrollLeft,
    required this.onScrollRight,
    required this.onClear,
    required this.onRemove,
    required this.onReorder,
    this.showClearButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool canScrollLeft = currentStartIndex > 0;
    final bool canScrollRight = (currentStartIndex + maxVisibleImages) < selectedImages.length;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          // Vasenta nuolta
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: canScrollLeft ? Colors.black : Colors.grey,
            ),
            onPressed: canScrollLeft ? onScrollLeft : null,
            tooltip: AppLocalizations.of(context)!.scrollLeft,
          ),
          // Kuvajono
          Expanded(
            child: SizedBox(
              height: 80,
              child: ReorderableListView(
                scrollDirection: Axis.horizontal,
                onReorder: (int oldIndex, int newIndex) {
                  oldIndex += currentStartIndex;
                  newIndex += currentStartIndex;
                  onReorder(oldIndex, newIndex);
                },
                children: [
                  for (int i = currentStartIndex;
                      i < (currentStartIndex + maxVisibleImages) && i < selectedImages.length;
                      i++)
                    GestureDetector(
                      key: ValueKey(selectedImages[i]),
                      onTap: () => onRemove(i),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                selectedImages[i].thumb,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image, size: 60);
                                },
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Oikeaa nuolta
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: canScrollRight ? Colors.black : Colors.grey,
            ),
            onPressed: canScrollRight ? onScrollRight : null,
            tooltip: AppLocalizations.of(context)!.scrollRight,
          ),
          // Tyhjennysikoni (näkyy vain, jos showClearButton on true)
          if (showClearButton)
            IconButton(
              icon: const Icon(Icons.delete_sweep, color: Colors.red),
              onPressed: onClear,
              tooltip: 'Tyhjennä kuvajono',
            ),
        ],
      ),
    );
  }
}
