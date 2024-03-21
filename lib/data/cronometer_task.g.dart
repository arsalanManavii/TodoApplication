// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cronometer_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CronometerTaskAdapter extends TypeAdapter<CronometerTask> {
  @override
  final int typeId = 4;

  @override
  CronometerTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CronometerTask(
      image: fields[0] as String,
      title: fields[1] as String,
      subTitle: fields[2] as String,
      minut: fields[3] as int,
      seconds: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CronometerTask obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subTitle)
      ..writeByte(3)
      ..write(obj.minut)
      ..writeByte(4)
      ..write(obj.seconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CronometerTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
