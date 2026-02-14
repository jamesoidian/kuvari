// lib/pages/saved_image_stories_page.dart

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/pages/image_viewer_page.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/widgets/tag_management_dialog.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:kuvari_app/models/tag.dart';
import 'package:kuvari_app/services/storage_constants.dart';

class SavedImageStoriesPage extends StatefulWidget {
  final Box<ImageStory>? imageStoriesBox;
  final Box<Tag>? tagsBox;

  const SavedImageStoriesPage({
    super.key,
    this.imageStoriesBox,
    this.tagsBox,
  });

  @override
  State<SavedImageStoriesPage> createState() => _SavedImageStoriesPageState();
}

class _SavedImageStoriesPageState extends State<SavedImageStoriesPage> {
  late final Box<ImageStory> imageStoriesBox =
      widget.imageStoriesBox ?? Hive.box<ImageStory>(StorageConstants.imageStoriesBox);
  late final Box<Tag> tagsBox = widget.tagsBox ?? Hive.box<Tag>(StorageConstants.tagsBox);

  final Map<String, int> _currentStartIndices = {};
  int _maxVisibleImages = 1;
  String _searchQuery = '';
  final List<String> _selectedTagIds = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double imageWidth = 80.0;
    const double carouselPadding = 48.0;
    const double clearButtonWidth = 48.0;
    final int currentMaxVisibleImages = max(1, ((screenWidth - carouselPadding - clearButtonWidth) / imageWidth).floor());

    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)?.savedImageStories ?? 'Saved Stories')),
      body: ValueListenableBuilder(
        valueListenable: imageStoriesBox.listenable(),
        builder: (context, Box<ImageStory> box, _) {
          final l10n = AppLocalizations.of(context);
          if (l10n == null) return const Center(child: CircularProgressIndicator());

          final stories = box.values.where((story) {
            final matchesSearch =
                story.name.toLowerCase().contains(_searchQuery);
            final matchesTags = _selectedTagIds.isEmpty ||
                _selectedTagIds.every((tagId) => story.tagIds.contains(tagId));
            return matchesSearch && matchesTags;
          }).toList();

          if (stories.isEmpty) {
            return Column(
              children: [
                _buildSearchAndFilters(),
                Expanded(
                  child: Center(
                    child: Text(l10n.noSavedImageStories),
                  ),
                ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchAndFilters(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.deleteInfoLabel,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Text(
                      l10n.tagInfoLabel,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final ImageStory story = stories[index];

                    return Dismissible(
                      key: Key(story.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      onDismissed: (direction) {
                        story.delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text(l10n.imageStoryDeleted(story.name))),
                        );
                      },
                      child: GestureDetector(
                        onLongPress: () async {
                          final List<String>? selectedTagIds =
                              await showDialog<List<String>>(
                            context: context,
                            builder: (context) => TagManagementDialog(
                              initialTagIds: story.tagIds,
                              tagsBox: tagsBox,
                              imageStoriesBox: imageStoriesBox,
                            ),
                          );

                          if (selectedTagIds != null) {
                            // Päivitetään tarinan avainsanat
                            final updatedStory = ImageStory(
                              id: story.id,
                              name: story.name,
                              images: story.images,
                              tagIds: selectedTagIds,
                            );

                            // Koska story on HiveObject ja olemme ListView.builderissa boxin listenablen kanssa,
                            // meidän pitäisi joko päivittää olemassa oleva objekti tai korvata se boxissa.
                            // HiveObjectsien tapauksessa save() on paras jos vain kentät muuttuvat,
                            // mutta tagIds on final joissain tapauksissa jos se generoitiin niin.
                            // Tarkistetaan image_story.dart - siellä se ON final.
                            // Joten korvataan boxissa samalla avaimella.

                            final key = story.key ??
                                box.keys.firstWhere(
                                    (k) => box.get(k)?.id == story.id);
                            await box.put(key, updatedStory);

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text(l10n.imageStorySaved(story.name))),
                              );
                            }
                          }
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(story.name),
                            subtitle: SelectedImagesCarousel(
                              selectedImages: story.images,
                              currentStartIndex:
                                  _currentStartIndices[story.id] ?? 0,
                              maxVisibleImages: currentMaxVisibleImages,
                              onClear: () {},
                              onRemove: (i) {},
                              showClearButton: false,
                              onReorder: (int oldIndex, int newIndex) {},
                            ),
                            trailing: IconButton(
                              icon: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.teal,
                                    size: 24,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                final analytics = FirebaseAnalytics.instance;

                                // Kirjaa katselutapahtuma
                                analytics.logEvent(
                                  name: 'view_image_story',
                                  parameters: {
                                    'image_count': story.images.length,
                                    'source': 'saved_stories',
                                  },
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ImageViewerPage(images: story.images),
                                  ),
                                );
                              },
                              tooltip: l10n.viewImageStory,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchStories,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: tagsBox.listenable(),
          builder: (context, Box<Tag> box, _) {
            final tags = box.values.toList();
            if (tags.isEmpty) return const SizedBox.shrink();

            return SizedBox(
              height: 48,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  final isSelected = _selectedTagIds.contains(tag.id);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: FilterChip(
                      label: Text(tag.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedTagIds.add(tag.id);
                          } else {
                            _selectedTagIds.remove(tag.id);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
