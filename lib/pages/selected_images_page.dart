// lib/pages/selected_images_page.dart

import 'package:flutter/material.dart';
import 'package:kuha_app/models/kuha_image.dart';

class SelectedImagesPage extends StatelessWidget {
  final List<KuhaImage> images;

  const SelectedImagesPage({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Valitut kuvat')),
        body: const Center(child: Text('Ei valittuja kuvia.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Valitut kuvat')),
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
