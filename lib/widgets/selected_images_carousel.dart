// lib/widgets/selected_images_carousel.dart

import 'package:flutter/material.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectedImagesCarousel extends StatefulWidget {
  final List<KuvariImage> selectedImages;
  final int currentStartIndex;
  final int maxVisibleImages;
  final VoidCallback onClear;
  final Function(int) onRemove;
  final Function(int, int) onReorder;
  final bool showClearButton;

  const SelectedImagesCarousel({
    Key? key,
    required this.selectedImages,
    required this.currentStartIndex,
    required this.maxVisibleImages,
    required this.onClear,
    required this.onRemove,
    required this.onReorder,
    this.showClearButton = true,
  }) : super(key: key);

  @override
  _SelectedImagesCarouselState createState() => _SelectedImagesCarouselState();
}

class _SelectedImagesCarouselState extends State<SelectedImagesCarousel> {
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollButtons());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    _updateScrollButtons();
  }

  void _updateScrollButtons() {
    if (!mounted) return;
    setState(() {
      _canScrollLeft = _scrollController.hasClients && _scrollController.offset > 0;
      _canScrollRight = _scrollController.hasClients && 
          _scrollController.offset < _scrollController.position.maxScrollExtent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          // Kuvajono
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: SizedBox(
              height: 80,
              child: ReorderableListView(
                scrollController: _scrollController,
                scrollDirection: Axis.horizontal,
                onReorder: widget.onReorder,
                children: [
                  for (int i = 0; i < widget.selectedImages.length; i++)
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
          // Scroll indicators
          if (_canScrollLeft)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 40,
                color: Colors.black26,
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ),
          if (_canScrollRight)
            Positioned(
              right: 40,
              top: 0,
              bottom: 0,
              child: Container(
                width: 40,
                color: Colors.black26,
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ),
          // Clear button
          if (widget.showClearButton)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(Icons.delete_sweep, color: Colors.red),
                onPressed: widget.onClear,
                tooltip: 'Tyhjennä kuvajono',
              ),
            ),
        ],
      ),
    );
  }
}
