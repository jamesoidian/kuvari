// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kuvari_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KuvariImageAdapter extends TypeAdapter<KuvariImage> {
  @override
  final int typeId = 1;

  @override
  KuvariImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KuvariImage(
      author: fields[0] as String,
      name: fields[1] as String,
      thumb: fields[2] as String,
      url: fields[3] as String,
      uid: fields[4] as int,
      uuid: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, KuvariImage obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.thumb)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.uid)
      ..writeByte(5)
      ..write(obj.uuid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KuvariImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
