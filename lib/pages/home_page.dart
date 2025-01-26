// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:tarinappi/models/image_item.dart';
import 'package:tarinappi/services/kuha_service.dart';
import 'package:tarinappi/pages/selected_images_page.dart';
import 'package:tarinappi/pages/image_viewer_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<KuhaImage> _images = [];
  List<KuhaImage> _selectedImages = [];

  bool _isLoading = false;

  // Scroll controller for the selected images list
  final ScrollController _scrollController = ScrollController();

  // Current starting index of the visible images
  int _currentStartIndex = 0;

  // Maximum number of visible images
  final int _maxVisibleImages = 4;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Haku-funktio
  Future<void> _search() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _images = [];
    });

    try {
      final results = await KuhaService.searchImages(query);
      setState(() {
        _images = results;
      });
    } catch (e) {
      // Virheenkäsittely
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Virhe haussa: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Kuvan valinta
  void _selectImage(KuhaImage image) {
    setState(() {
      _selectedImages.add(image);
      // Jos lisätty kuva ylittää näkyvien kuvien määrän, siirrytään oikealle
      if (_selectedImages.length > _maxVisibleImages) {
        _currentStartIndex = _selectedImages.length - _maxVisibleImages;
        _scrollController.animateTo(
          (_currentStartIndex * 64.0), // 60 (kuvan leveys) + 4 (padding)
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Kuvan poistaminen jonosta
  void _removeSelectedImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
      // Jos poistettu kuva vaikutti aloitusindeksiin, päivitetään se
      if (_currentStartIndex > _selectedImages.length - _maxVisibleImages) {
        _currentStartIndex = (_selectedImages.length - _maxVisibleImages).clamp(0, _selectedImages.length);
        _scrollController.animateTo(
          (_currentStartIndex * 64.0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Kuvien järjestyksen muuttaminen
  void _reorderSelectedImages(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final KuhaImage image = _selectedImages.removeAt(oldIndex);
      _selectedImages.insert(newIndex, image);

      // Päivitetään startIndex, jos tarpeen
      if (_currentStartIndex > _selectedImages.length - _maxVisibleImages) {
        _currentStartIndex = (_selectedImages.length - _maxVisibleImages).clamp(0, _selectedImages.length);
        _scrollController.animateTo(
          (_currentStartIndex * 64.0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Kuvajonon tyhjentäminen
  void _clearSelectedImages() {
    if (_selectedImages.isEmpty) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tyhjennä kuvajono'),
          content: const Text('Haluatko varmasti tyhjentää kaikki valitut kuvat?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Peruuta
              child: const Text('Peruuta'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedImages.clear();
                  _currentStartIndex = 0;
                });
                Navigator.of(context).pop(); // Sulje dialogi
              },
              child: const Text('Kyllä'),
            ),
          ],
        );
      },
    );
  }

  // Siirtyminen "pino-näkymään"
  void _navigateToSelectedImages() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectedImagesPage(images: _selectedImages),
      ),
    );
  }

  // Siirtyminen ImageViewerPage:lle
  void _navigateToImageViewer() {
    if (_selectedImages.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImageViewerPage(images: _selectedImages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuha App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: _selectedImages.isNotEmpty ? _navigateToSelectedImages : null,
            tooltip: 'Näytä valitut kuvat',
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Palataan HomePage:lle
              // Koska olemme jo HomePage:ssa, tämä voi olla tulevaisuudessa käytetty navigointiin
            },
            tooltip: 'Home',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Kuvajono valituista kuvista ja tyhjennysikoni
            if (_selectedImages.isNotEmpty)
              Container(
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
                        color: _currentStartIndex > 0 ? Colors.black : Colors.grey,
                      ),
                      onPressed: _currentStartIndex > 0
                          ? () {
                              setState(() {
                                _currentStartIndex = (_currentStartIndex - _maxVisibleImages).clamp(0, _selectedImages.length - _maxVisibleImages);
                              });
                              _scrollController.animateTo(
                                (_currentStartIndex * 64.0), // 60 (kuvan leveys) + 4 (padding)
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      tooltip: 'Selaa vasemmalle',
                    ),
                    // Kuvajono
                    Expanded(
                      child: SizedBox(
                        height: 80,
                        child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImages.length,
                          itemBuilder: (context, index) {
                            // Näytetään vain näkyvät kuvat
                            if (index < _currentStartIndex || index >= _currentStartIndex + _maxVisibleImages) {
                              return const SizedBox.shrink();
                            }
                            final image = _selectedImages[index];
                            return GestureDetector(
                              onTap: () => _removeSelectedImage(index),
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
                                    // Poisto-ikoni näkyviin
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
                        color: (_currentStartIndex + _maxVisibleImages) < _selectedImages.length ? Colors.black : Colors.grey,
                      ),
                      onPressed: (_currentStartIndex + _maxVisibleImages) < _selectedImages.length
                          ? () {
                              setState(() {
                                _currentStartIndex = (_currentStartIndex + _maxVisibleImages).clamp(0, _selectedImages.length - _maxVisibleImages);
                              });
                              _scrollController.animateTo(
                                (_currentStartIndex * 64.0),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      tooltip: 'Selaa oikealle',
                    ),
                    // Tyhjennysikoni
                    IconButton(
                      icon: const Icon(Icons.delete_sweep, color: Colors.red),
                      onPressed: _clearSelectedImages,
                      tooltip: 'Tyhjennä kuvajono',
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),

            // Hakukenttä
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Hae kuvalla esim. apina',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _search,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Ladataan tai näytetään hakutulokset
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _images.isEmpty
                      ? const Center(child: Text('Ei hakutuloksia'))
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // kaksi saraketta rinnakkain
                            childAspectRatio: 0.8,
                          ),
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            final img = _images[index];
                            return GestureDetector(
                              onTap: () => _selectImage(img),
                              child: Card(
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
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToImageViewer,
        child: const Icon(Icons.play_arrow),
        tooltip: 'Näytä kuvat',
      ),
    );
  }
}
