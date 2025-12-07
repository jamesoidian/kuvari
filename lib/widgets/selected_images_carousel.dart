// lib/widgets/selected_images_carousel.dart

import 'package:flutter/material.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/widgets/kuvari_image_display.dart';

class SelectedImagesCarousel extends StatefulWidget {
  final List<KuvariImage> selectedImages;
  final int currentStartIndex;
  final int maxVisibleImages;
  final VoidCallback onClear;
  final Function(int) onRemove;
  final Function(int, int) onReorder;
  final bool showClearButton;

  const SelectedImagesCarousel({
    super.key,
    required this.selectedImages,
    required this.currentStartIndex,
    required this.maxVisibleImages,
    required this.onClear,
    required this.onRemove,
    required this.onReorder,
    this.showClearButton = true,
  });

  @override
  State<SelectedImagesCarousel> createState() => _SelectedImagesCarouselState();
}

class _SelectedImagesCarouselState extends State<SelectedImagesCarousel> {
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = false;
  late int _previousItemCount;

  @override
  void initState() {
    super.initState();
    _previousItemCount = widget.selectedImages.length;
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollButtons());
  }

  @override
  void didUpdateWidget(covariant SelectedImagesCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollButtons();
      if (widget.selectedImages.length > _previousItemCount) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
      _previousItemCount = widget.selectedImages.length;
    });
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
      _canScrollLeft =
          _scrollController.hasClients && _scrollController.offset > 0;
      _canScrollRight = _scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0 &&
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
            padding:
                EdgeInsets.only(right: widget.showClearButton ? 40.0 : 0.0),
            child: SizedBox(
              height: 80,
              child: ReorderableListView(
                scrollController: _scrollController,
                scrollDirection: Axis.horizontal,
                onReorder: widget.onReorder,
                children: [
                  for (int i = 0; i < widget.selectedImages.length; i++)
                    GestureDetector(
                      key: ValueKey(widget.selectedImages[i]),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: KuvariImageDisplay(
                                  url: widget.selectedImages[i].thumb,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorWidget: const Icon(Icons.broken_image, size: 60),
                                ),
                              ),
                              if (widget.showClearButton)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () => widget.onRemove(i),
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
                                ),
                            ],
                          ),
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
              child: Opacity(
                opacity: 0.9,
                child: Container(
                  width: 40,
                  color: Colors.black26,
                  alignment: Alignment.center,
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
            ),
          if (_canScrollRight)
            Positioned(
              right: widget.showClearButton ? 40 : 0,
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
                tooltip: AppLocalizations.of(context)!.clearImageStory,
              ),
            ),
        ],
      ),
    );
  }
}
