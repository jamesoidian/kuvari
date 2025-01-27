// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:kuha_app/models/kuha_image.dart';
import 'package:kuha_app/services/kuha_service.dart';
import 'package:kuha_app/pages/selected_images_page.dart';
import 'package:kuha_app/pages/image_viewer_page.dart';
import 'package:kuha_app/pages/info_page.dart';
import 'package:kuha_app/widgets/kuha_search_bar.dart';
import 'package:kuha_app/widgets/selected_images_carousel.dart';
import 'package:kuha_app/widgets/image_grid.dart';

class HomePage extends StatefulWidget {
  final KuhaService kuhaService;

  const HomePage({Key? key, required this.kuhaService}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<KuhaImage> _images = [];
  List<KuhaImage> _selectedImages = [];

  bool _isLoading = false;

  // Current starting index of the visible images
  int _currentStartIndex = 0;

  // Maximum number of visible images
  final int _maxVisibleImages = 4;

  @override
  void dispose() {
    _searchController.dispose(); // Varmistetaan, että controllerit suljetaan
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
      final results = await widget.kuhaService.searchImages(query);
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
      }
    });
  }

  // Kuvan poistaminen jonosta
  void _removeSelectedImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
      // Jos poistettu kuva vaikutti aloitusindeksiin, päivitetään se
      if (_currentStartIndex > _selectedImages.length - _maxVisibleImages) {
        _currentStartIndex = (_selectedImages.length - _maxVisibleImages)
            .clamp(0, _selectedImages.length);
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
          content:
              const Text('Haluatko varmasti tyhjentää kaikki valitut kuvat?'),
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

  // Navigoi vasemmalle kuvajonossa
  void _scrollLeft() {
    setState(() {
      _currentStartIndex = (_currentStartIndex - _maxVisibleImages)
          .clamp(0, _selectedImages.length - _maxVisibleImages);
    });
  }

  // Navigoi oikealle kuvajonossa
  void _scrollRight() {
    setState(() {
      _currentStartIndex = (_currentStartIndex + _maxVisibleImages)
          .clamp(0, _selectedImages.length - _maxVisibleImages);
    });
  }

  // Päivitä hakukenttä tyhjennyksen jälkeen
  void _clearSearch() {
    _searchController.clear();
    setState(() {}); // Päivitetään UI:ta
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kuvari',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Keskittää otsikon
        backgroundColor: Colors.teal, // Taustaväri
        foregroundColor: Colors.white, // Etualan väri (teksti ja ikonit)
        shadowColor: Colors.tealAccent, // Varjon väri
        elevation: 6.0, // Varjon korkeus
        surfaceTintColor: Colors.teal.shade700, // Material 3 pinnansävy
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.0),
          ),
        ), // Pyöristetyt reunat
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ), // Gradient taustalle
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed:
                _selectedImages.isNotEmpty ? _navigateToSelectedImages : null,
            tooltip: 'Näytä valitut kuvat',
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const InfoPage(),
                ),
              );
            },
            tooltip: 'Tietoa sovelluksesta',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Kuvajono valituista kuvista ja tyhjennysikoni
            if (_selectedImages.isNotEmpty)
              SelectedImagesCarousel(
                selectedImages: _selectedImages,
                currentStartIndex: _currentStartIndex,
                maxVisibleImages: _maxVisibleImages,
                onScrollLeft: _scrollLeft,
                onScrollRight: _scrollRight,
                onClear: _clearSelectedImages,
                onRemove: _removeSelectedImage,
              ),
            const SizedBox(height: 8),

            // Hakukenttä
            KuhaSearchBar(
              controller: _searchController,
              onSearch: _search,
              onClear: _clearSearch,
            ),
            const SizedBox(height: 8),

            // Ladataan tai näytetään hakutulokset
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ImageGrid(
                      images: _images,
                      selectedImages: _selectedImages,
                      onSelect: _selectImage,
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToImageViewer,
        tooltip: 'Näytä kuvat',
        backgroundColor: Colors.teal, // FABin taustaväri
        foregroundColor: Colors.white, // Ikonin oletusväri
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ulompi ikoni toimii borderina
            Icon(
              Icons.play_arrow,
              color: Colors.white, // Borderin väri
              size: 30, // Suurempi koko borderille
            ),
            // Sisempi ikoni
            Icon(
              Icons.play_arrow,
              color: Colors.teal, // Ikonin väri
              size: 24, // Pienempi koko ikonille
            ),
          ],
        ),
      ),
    );
  }
}
