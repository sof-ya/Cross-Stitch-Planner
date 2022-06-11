// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatisticAdapter extends TypeAdapter<Statistic> {
  @override
  final int typeId = 2;

  @override
  Statistic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Statistic(
      name_shema: fields[1] as String?,
      date: fields[2] as DateTime?,
      cross_count: fields[3] as int?,
      file: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Statistic obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name_shema)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.cross_count)
      ..writeByte(4)
      ..write(obj.file);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatisticAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
