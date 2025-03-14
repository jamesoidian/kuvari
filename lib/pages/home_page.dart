// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:kuvari_app/utils.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/services/kuvari_service.dart';
import 'package:kuvari_app/pages/image_viewer_page.dart';
import 'package:kuvari_app/widgets/home_app_bar.dart';
import 'package:kuvari_app/widgets/home_search_section.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';
import 'package:kuvari_app/widgets/image_grid.dart';
import 'package:kuvari_app/widgets/category_selection_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HomePage extends StatefulWidget {
  final KuvariService kuvariService;
  final Function(Locale) setLocale;
  final FirebaseAnalytics analytics;

  const HomePage({
    super.key,
    required this.kuvariService,
    required this.setLocale,
    required this.analytics,
  });

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

    await widget.analytics.logEvent(
      name: 'search',
      parameters: {
        'query': query,
        'language': Localizations.localeOf(context).languageCode,
      },
    );

    setState(() {
      _isLoading = true;
      _images = [];
    });

    try {
      final languageCode = Localizations.localeOf(context).languageCode;
      final results = await widget.kuvariService
          .searchImages(query, _selectedCategories, languageCode);
      setState(() {
        _images = results;
      });
    } catch (e) {
      // Virheenkäsittely
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('${AppLocalizations.of(context)!.searchError} $e')),
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
      final newImage = KuvariImage(
        author: image.author,
        name: image.name,
        thumb: image.thumb,
        url: image.url,
        uid: image.uid,
      );
      _selectedImages.add(newImage);
      if (_selectedImages.length > _maxVisibleImages) {
        _currentStartIndex = max(0, _selectedImages.length - _maxVisibleImages);
      }
      _shouldSelectAll = true;
      _searchController.clear(); // Clears the search field upon selection.
    });
  }

  // Kuvan poistaminen jonosta
  void _removeSelectedImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
      if (_currentStartIndex > _selectedImages.length - _maxVisibleImages) {
        _currentStartIndex = max(0, _selectedImages.length - _maxVisibleImages);
      }
    });
  }

  void _onReorderSelectedImages(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final image = _selectedImages.removeAt(oldIndex);
      _selectedImages.insert(newIndex, image);
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
          content:
              Text(AppLocalizations.of(context)!.emptySelectedImagesConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Peruuta
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  _selectedImages.clear();
                  _currentStartIndex = 0;
                  // Asetetaan tila valitsemaan kaikki teksti seuraavalla taputuksella
                  _shouldSelectAll = true;
                });
                Navigator.of(context).pop(); // Sulje dialogi
              },
              child: Text(AppLocalizations.of(context)!.clear),
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
    final Box<ImageStory> imageStoriesBox =
        Hive.box<ImageStory>('imageStories');

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.saveImageStory),
          content: TextField(
            controller: storyNameController,
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.giveImageStoryName),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = storyNameController.text.trim();
                if (name.isNotEmpty) {
                  final newStory = ImageStory(
                    id: const Uuid().v4(),
                    name: name,
                    images: List<KuvariImage>.from(_selectedImages),
                  );

                  imageStoriesBox.add(newStory);

                  await widget.analytics.logEvent(
                    name: 'save_image_story',
                    parameters: {
                      'story_name': name,
                      'image_count': newStory.images.length,
                    },
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(AppLocalizations.of(context)!
                            .imageStorySaved(newStory.name))),
                  );

                  setState(() {
                    _selectedImages.clear();
                    _currentStartIndex = 0;
                  });

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

    widget.analytics.logEvent(
      name: 'view_image_story',
      parameters: {
        'image_count': _selectedImages.length,
        'source': 'home_page',
      },
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImageViewerPage(images: _selectedImages),
      ),
    );
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
      _searchController.selection = TextSelection(
          baseOffset: 0, extentOffset: _searchController.text.length);
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

  @override
  Widget build(BuildContext context) {
    _maxVisibleImages = calculateMaxVisibleImages(context);
    return WillPopScope(
      onWillPop: () async {
        // If there are selected images, block the pop event so the list isn't cleared.
        if (_selectedImages.isNotEmpty) {
          // Optionally, you could show a confirmation dialog here if you want to allow exit.
          return false; // Prevents the back navigation.
        }
        return true; // Allows the back navigation if no images are selected.
      },
      child: Scaffold(
        appBar: HomeAppBar(
          selectedImages: _selectedImages,
          onSave: _saveImageStory,
          setLocale: widget.setLocale,
          analytics: widget.analytics,
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
                  onClear: _clearSelectedImages,
                  onRemove: _removeSelectedImage,
                  onReorder: _onReorderSelectedImages,
                ),
              const SizedBox(height: 8),

              // Hakukenttä
              HomeSearchSection(
                controller: _searchController,
                onSearch: _search,
                onClear: _clearSearch,
                onTap: _onSearchFieldTap,
                onSelectCategories: _selectCategories,
                showFilterBadge: _selectedCategories.length < 8,
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
        floatingActionButton: _selectedImages.isNotEmpty
            ? FloatingActionButton(
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
              )
            : null,
      ),
    );
  }
}
