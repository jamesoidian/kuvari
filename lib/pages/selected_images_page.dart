// lib/pages/selected_images_page.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:uuid/uuid.dart';

class SelectedImagesPage extends StatelessWidget {
  final List<KuvariImage> images;

  const SelectedImagesPage({Key? key, required this.images}) : super(key: key);

  Future<void> _saveImageStory(BuildContext context) async {
    if (images.isEmpty) return;

    final storyNameController = TextEditingController();
    final Box<ImageStory> imageStoriesBox =
        Hive.box<ImageStory>('imageStories');

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Anna kuvajonon nimi'),
          content: TextField(
            controller: storyNameController,
            decoration: const InputDecoration(labelText: 'Nimi'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Peruuta'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = storyNameController.text.trim();
                if (name.isNotEmpty) {
                  final newStory = ImageStory(
                    id: const Uuid().v4(),
                    name: name,
                    images: List<KuvariImage>.from(images), // Syväkopio
                  );

                  imageStoriesBox.add(newStory);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Kuvajono "$name" tallennettu.')),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Tallenna'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Valitut kuvat')),
        body: const Center(child: Text('Ei valittuja kuvia.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Valitut kuvat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveImageStory(context),
            tooltip: 'Tallenna kuvajono',
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Kaksi saraketta
          childAspectRatio: 0.8,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final img = images[index];
          return Card(
            elevation: 2,
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    img.thumb,
                    fit: BoxFit.cover,
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
          );
        },
      ),
    );
  }
}
