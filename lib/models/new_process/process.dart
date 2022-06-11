import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'process.g.dart';

@HiveType(typeId: 0)
class Process extends HiveObject {
  @HiveField(0)
  @HiveField(1)
  String? name_shema;
  @HiveField(2)
  int? crossCount;
  @HiveField(3)
  String? comment;
  @HiveField(4)
  String? file;
  @HiveField(5)
  DateTime? startDate;
  @HiveField(6)
  DateTime? finishDate;
  @HiveField(7)
  String? name_autor;


  Process({this.name_shema = '', required this.crossCount, required this.comment, required this.file, required this.startDate, required this.finishDate, required this.name_autor});
}
