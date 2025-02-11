// lib/pages/image_viewer_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kuvari_app/models/kuvari_image.dart';

class ImageViewerPage extends StatefulWidget {
  final List<KuvariImage> images;

  const ImageViewerPage({super.key, required this.images});

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  late PageController _pageController;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  bool _showLeftIndicator = false;
  bool _showRightIndicator = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      setState(() {
        _showLeftIndicator = _scrollController.offset > 0;
        _showRightIndicator = _scrollController.offset < _scrollController.position.maxScrollExtent;
      });
    }
  }

  void _scrollLeft() {
    final double offset = _scrollController.offset - MediaQuery.of(context).size.width;
    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollRight() {
    final double offset = _scrollController.offset + MediaQuery.of(context).size.width;
    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      setState(() {
        _showLeftIndicator = _scrollController.offset > 0;
        _showRightIndicator = _scrollController.offset < _scrollController.position.maxScrollExtent;
      });
    }
    return true;
  }

  Widget _buildPortraitView() {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final img = widget.images[index];
              return Center(
                child: InteractiveViewer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.network(
                          img.url,
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
                      const SizedBox(height: 10),
                      Text(
                        'Kuva: Papunetin kuvapankki, papunet.net\n${img.author}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeView() {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.images.map((img) {
                return Container(
                  width: screenHeight * 0.8,
                  margin: const EdgeInsets.all(8.0),
                  child: InteractiveViewer(
                    child: Image.network(
                      img.url,
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
              }).toList(),
            ),
          ),
        ),
        if (_showLeftIndicator)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _scrollLeft,
              child: Container(
                width: 40,
                color: Colors.black26,
                child: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ),
          ),
        if (_showRightIndicator)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _scrollRight,
              child: Container(
                width: 40,
                color: Colors.black26,
                child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.imageViewer)),
        body: Center(child: Text(AppLocalizations.of(context)!.noImagesToView)),
      );
    }

    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.imageViewer} ${_currentPage + 1}/${widget.images.length}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            tooltip: AppLocalizations.of(context)!.home,
          ),
        ],
      ),
      body: orientation == Orientation.portrait
          ? _buildPortraitView()
          : _buildLandscapeView(),
    );
  }
}
