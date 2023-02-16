// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_clock_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorldClockModelAdapter extends TypeAdapter<WorldClockModel> {
  @override
  final int typeId = 0;

  @override
  WorldClockModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorldClockModel(
      fields[0] as DateTime,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorldClockModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorldClockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
