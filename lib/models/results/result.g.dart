// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultAdapter extends TypeAdapter<Result> {
  @override
  final int typeId = 3;

  @override
  Result read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Result(
      name_shema: fields[1] as String?,
      comment: fields[2] as String?,
      file: fields[3] as String?,
      startDate: fields[4] as DateTime?,
      finishDate: fields[5] as DateTime?,
      name_autor: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Result obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.name_shema)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.file)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.finishDate)
      ..writeByte(6)
      ..write(obj.name_autor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
