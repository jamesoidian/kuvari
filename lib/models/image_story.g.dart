// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_story.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageStoryAdapter extends TypeAdapter<ImageStory> {
  @override
  final int typeId = 0;

  @override
  ImageStory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageStory(
      id: fields[0] as String,
      name: fields[1] as String,
      images: (fields[2] as List).cast<KuhaImage>(),
    );
  }

  @override
  void write(BinaryWriter writer, ImageStory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageStoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
