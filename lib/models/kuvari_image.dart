import 'package:hive/hive.dart';

part 'kuvari_image.g.dart';

@HiveType(typeId: 1)
class KuvariImage {
  @HiveField(0)
  final String author;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String thumb;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final int uid;

  KuvariImage({
    required this.author,
    required this.name,
    required this.thumb,
    required this.url,
    required this.uid,
  });

  // Tehdään tehtaan konstruktori, joka luo olion JSONista.
  factory KuvariImage.fromJson(Map<String, dynamic> json) {
    return KuvariImage(
      author: json['author'] ?? '',
      name: json['name'] ?? '',
      thumb: json['thumb'] ?? '',
      url: json['url'] ?? '',
      uid: json['uid'] ?? 0,
    );
  }
}
