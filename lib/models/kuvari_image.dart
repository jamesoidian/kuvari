import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

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

  @HiveField(5)
  final String uuid;

  KuvariImage({
    required this.author,
    required this.name,
    required this.thumb,
    required this.url,
    required this.uid,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  // Tehdään tehtaan konstruktori, joka luo olion JSONista.
  factory KuvariImage.fromJson(Map<String, dynamic> json) {
    dynamic uidData = json['uid'];
    int parsedUid = 0;
    if (uidData is int) {
      parsedUid = uidData;
    } else if (uidData is String) {
      parsedUid = int.tryParse(uidData) ?? 0;
    }

    return KuvariImage(
      author: json['author'] ?? '',
      name: json['name'] ?? '',
      thumb: json['thumb'] ?? '',
      url: json['url'] ?? '',
      uid: parsedUid,
      uuid: const Uuid().v4(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KuvariImage && uuid == other.uuid;
  }

  @override
  int get hashCode => uuid.hashCode;
}
