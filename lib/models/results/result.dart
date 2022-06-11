import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'result.g.dart';

@HiveType(typeId: 3)
class Result extends HiveObject {

  @HiveField(1)
  String? name_shema;
  @HiveField(2)
  String? comment;
  @HiveField(3)
  String? file;
  @HiveField(4)
  DateTime? startDate;
  @HiveField(5)
  DateTime? finishDate;
  @HiveField(6)
  String? name_autor;


  Result ({this.name_shema = '', required this.comment, required this.file, required this.startDate, required this.finishDate, required this.name_autor});
}
