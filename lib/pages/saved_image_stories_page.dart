// lib/pages/saved_image_stories_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/pages/image_viewer_page.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SavedImageStoriesPage extends StatefulWidget {
  const SavedImageStoriesPage({Key? key}) : super(key: key);

  @override
  State<SavedImageStoriesPage> createState() => _SavedImageStoriesPageState();
}

class _SavedImageStoriesPageState extends State<SavedImageStoriesPage> {
  final Box<ImageStory> imageStoriesBox = Hive.box<ImageStory>('imageStories');
  final Map<String, int> _currentStartIndices = {};

  static const int _maxVisibleImages = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.savedImageStories),
      ),
      body: ValueListenableBuilder(
        valueListenable: imageStoriesBox.listenable(),
        builder: (context, Box<ImageStory> box, _) {
          // Hae kaikki kuvajonot suoraan Hive-tietokannasta
          final stories = box.values.toList();

          if (stories.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noSavedImageStories),
            );
          }

          return ListView.builder(
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
                    SnackBar(content: Text(AppLocalizations.of(context)!.imageStoryDeleted(name: story.name))),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(story.name),
                    subtitle: SelectedImagesCarousel(
                      selectedImages: story.images,
                      currentStartIndex: _currentStartIndices[story.id] ?? 0,
                      maxVisibleImages: _maxVisibleImages,
                      onScrollLeft: () {
                        setState(() {
                          _currentStartIndices[story.id] =
                              ((_currentStartIndices[story.id] ?? 0) - 1)
                                  .clamp(0, story.images.length - _maxVisibleImages);
                        });
                      },
                      onScrollRight: () {
                        setState(() {
                          _currentStartIndices[story.id] =
                              ((_currentStartIndices[story.id] ?? 0) + 1)
                                  .clamp(0, story.images.length - _maxVisibleImages);
                        });
                      },
                      onClear: () {},
                      onRemove: (i) {},
                      showClearButton: false,
                    ),
                    trailing: IconButton(
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ImageViewerPage(images: story.images),
                          ),
                        );
                      },
                      tooltip: AppLocalizations.of(context)!.viewImageStory,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
