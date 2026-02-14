// lib/models/tag.dart

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'tag.g.dart';

@HiveType(typeId: 2)
class Tag extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  Tag({
    required this.name,
    String? id,
  }) : id = id ?? const Uuid().v4();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Tag && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
