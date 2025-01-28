// lib/pages/saved_image_stories_page.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuha_app/models/image_story.dart';
import 'package:kuha_app/widgets/selected_images_carousel.dart';

class SavedImageStoriesPage extends StatelessWidget {
  const SavedImageStoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Box<ImageStory> imageStoriesBox = Hive.box<ImageStory>('imageStories');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tallennetut Kuvajonot'),
      ),
      body: ValueListenableBuilder(
        valueListenable: imageStoriesBox.listenable(),
        builder: (context, Box<ImageStory> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('Ei tallennettuja kuvajonoja.'),
            );
          }

          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              final ImageStory story = box.getAt(index)!;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(story.name),
                  subtitle: SelectedImagesCarousel(
                    selectedImages: story.images,
                    currentStartIndex: 0,
                    maxVisibleImages: 3,
                    onScrollLeft: () {},
                    onScrollRight: () {},
                    onClear: () {},
                    onRemove: (i) {},
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      story.delete();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Kuvajono poistettu.')),
                      );
                    },
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
