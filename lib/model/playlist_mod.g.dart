// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_mod.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListModelAdapter extends TypeAdapter<PlayListModel> {
  @override
  final int typeId = 1;

  @override
  PlayListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListModel(
      name: fields[1] as String,
      songListdb: (fields[2] as List).cast<dynamic>(),
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayListModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.songListdb);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}