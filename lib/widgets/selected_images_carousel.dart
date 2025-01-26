// lib/widgets/selected_images_carousel.dart

import 'package:flutter/material.dart';
import 'package:kuha_app/models/kuha_image.dart';

class SelectedImagesCarousel extends StatelessWidget {
  final List<KuhaImage> selectedImages;
  final int currentStartIndex;
  final int maxVisibleImages;
  final VoidCallback onScrollLeft;
  final VoidCallback onScrollRight;
  final VoidCallback onClear;
  final Function(int) onRemove;

  const SelectedImagesCarousel({
    Key? key,
    required this.selectedImages,
    required this.currentStartIndex,
    required this.maxVisibleImages,
    required this.onScrollLeft,
    required this.onScrollRight,
    required this.onClear,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool canScrollLeft = currentStartIndex > 0;
    bool canScrollRight = (currentStartIndex + maxVisibleImages) < selectedImages.length;

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
            tooltip: 'Selaa vasemmalle',
          ),
          // Kuvajono
          Expanded(
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedImages.length,
                itemBuilder: (context, index) {
                  if (index < currentStartIndex || index >= currentStartIndex + maxVisibleImages) {
                    return const SizedBox.shrink();
                  }
                  final image = selectedImages[index];
                  return GestureDetector(
                    onTap: () => onRemove(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              image.thumb,
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
                          // Poisto-ikoni
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
                  );
                },
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
            tooltip: 'Selaa oikealle',
          ),
          // Tyhjennysikoni
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
