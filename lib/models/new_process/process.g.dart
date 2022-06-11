// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProcessAdapter extends TypeAdapter<Process> {
  @override
  final int typeId = 0;

  @override
  Process read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Process(
      name_shema: fields[0] as String?,
      crossCount: fields[2] as int?,
      comment: fields[3] as String?,
      file: fields[4] as String?,
      startDate: fields[5] as DateTime?,
      finishDate: fields[6] as DateTime?,
      name_autor: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Process obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name_shema)
      ..writeByte(2)
      ..write(obj.crossCount)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.file)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.finishDate)
      ..writeByte(7)
      ..write(obj.name_autor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProcessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
