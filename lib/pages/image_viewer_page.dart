// lib/pages/image_viewer_page.dart

import 'package:flutter/material.dart';
import 'package:tarinappi/models/image_item.dart';

class ImageViewerPage extends StatefulWidget {
  final List<KuhaImage> images;

  const ImageViewerPage({Key? key, required this.images}) : super(key: key);

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Image Viewer')),
        body: const Center(child: Text('Ei kuvia katsottavaksi.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Kuva ${_currentPage + 1}/${widget.images.length}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            tooltip: 'Home',
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          final img = widget.images[index];
          return Center(
            child: InteractiveViewer(
              child: Image.network(
                img.url, // Käytetään suurempaa kuvaa
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 100);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
