// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/services/kuvari_service.dart';
import 'package:kuvari_app/pages/image_viewer_page.dart';
import 'package:kuvari_app/pages/saved_image_stories_page.dart';
import 'package:kuvari_app/pages/info_page.dart';
import 'package:kuvari_app/widgets/kuvari_search_bar.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';
import 'package:kuvari_app/widgets/image_grid.dart';
import 'package:kuvari_app/widgets/category_selection_dialog.dart';
import 'package:kuvari_app/widgets/language_selector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  final KuvariService kuvariService;
  final Function(Locale) setLocale;

  const HomePage({
    Key? key, 
    required this.kuvariService,
    required this.setLocale,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<KuvariImage> _images = [];
  List<KuvariImage> _selectedImages = [];

  bool _isLoading = false;
  List<String> _selectedCategories = [
    'arasaac',
    'kuvako',
    'mulberry',
    'drawing',
    'sclera',
    'toisto',
    'photo',
    'sign',
  ]; // Oletuksena kaikki kategoriat valittuina

  // Current starting index of the visible images
  int _currentStartIndex = 0;

  // Maximum number of visible images
  late int _maxVisibleImages;

  // Tila, joka kertoo, että seuraavan kerran kun hakukenttä saa fokuksen, valitaan kaikki teksti
  bool _shouldSelectAll = false;

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
      final languageCode = Localizations.localeOf(context).languageCode;
      final results = await widget.kuvariService.searchImages(query, _selectedCategories, languageCode);
      setState(() {
        _images = results;
      });
    } catch (e) {
      // Virheenkäsittely
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.searchError} $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Kuvan valinta
  void _selectImage(KuvariImage image) {
    setState(() {
      _selectedImages.add(image);
      // Jos lisätty kuva ylittää näkyvien kuvien määrän, siirrytään oikealle
      if (_selectedImages.length > _maxVisibleImages) {
        _currentStartIndex = _selectedImages.length - _maxVisibleImages;
      }
      // Asetetaan tila valitsemaan kaikki teksti seuraavalla taputuksella
      _shouldSelectAll = true;
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
          title: Text(AppLocalizations.of(context)!.clearImageStory), 
          content: Text(AppLocalizations.of(context)!.emptySelectedImagesConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Peruuta
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedImages.clear();
                  _currentStartIndex = 0;
                  // Asetetaan tila valitsemaan kaikki teksti seuraavalla taputuksella
                  _shouldSelectAll = true;
                });
                Navigator.of(context).pop(); // Sulje dialogi
              },
              child:  Text(AppLocalizations.of(context)!.clear),
            ),
          ],
        );
      },
    );
  }

  // Kuvajonon tallentaminen
  Future<void> _saveImageStory() async {
  if (_selectedImages.isEmpty) return;

  final storyNameController = TextEditingController();
  final Box<ImageStory> imageStoriesBox = Hive.box<ImageStory>('imageStories');

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.saveImageStory),
        content: TextField(
          controller: storyNameController,
          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.giveImageStoryName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final name = storyNameController.text.trim();
              if (name.isNotEmpty) {
                final newStory = ImageStory(
                  id: const Uuid().v4(),
                  name: name,
                  images: List<KuvariImage>.from(_selectedImages),
                );

                imageStoriesBox.add(newStory);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.imageStorySaved(newStory.name))),
                );
                Navigator.of(context).pop();
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      );
    },
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
    setState(() {
      _images = []; // Tyhjennetään hakutulokset
    });
  }

  // Metodi, jota kutsutaan kun hakukenttä valitsee kaiken tekstin
  void _onSearchFieldTap() {
    if (_shouldSelectAll) {
      _searchController.selection =
          TextSelection(baseOffset: 0, extentOffset: _searchController.text.length);
      setState(() {
        _shouldSelectAll = false;
      });
    }
  }

  void _selectCategories() async {
    final selected = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return CategorySelectionDialog(selectedCategories: _selectedCategories);
      },
    );

    if (selected != null) {
      setState(() {
        _selectedCategories = selected;
      });
    }
  }

  void _updateMaxVisibleImages() {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double imageWidth = 60.0;
    const double imageSpacing = 8.0;
    const double sidePadding = 16.0;
    const double buttonWidth = 48.0;

    final double availableWidth = screenWidth - sidePadding - (buttonWidth * 3);
    int maxImages = ((availableWidth + imageSpacing) / (imageWidth + imageSpacing)).floor();
    _maxVisibleImages = max(1, maxImages);
  }

  @override
  Widget build(BuildContext context) {
    _updateMaxVisibleImages();
    return Scaffold(
      appBar: AppBar(
        leading: LanguageSelector(
          currentLocale: Localizations.localeOf(context),
          onLocaleChange: widget.setLocale,
        ),
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
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
            icon: const Icon(Icons.save),
            onPressed: _selectedImages.isNotEmpty ? _saveImageStory : null,
            tooltip: AppLocalizations.of(context)!.saveImageStory,
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SavedImageStoriesPage(),
                ),
              );
            },
            tooltip: AppLocalizations.of(context)!.savedImageStories,
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
            tooltip: AppLocalizations.of(context)!.info,
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
            Row(
              children: [
                Expanded(
                  child: KuvariSearchBar(
                    controller: _searchController,
                    onSearch: _search,
                    onClear: _clearSearch,
                    onTap: _onSearchFieldTap,
                  ),
                ),
                IconButton(
                  icon: Stack(
                    children: [
                      const Icon(Icons.filter_list),
                      if (_selectedCategories.length < 8) // Jos kaikki kategoriat eivät ole valittuina
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onPressed: _selectCategories,
                  tooltip: AppLocalizations.of(context)!.selectCategories,
                ),
              ],
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
        tooltip: AppLocalizations.of(context)!.viewImageStory,
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
