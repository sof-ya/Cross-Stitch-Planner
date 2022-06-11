import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'plan.g.dart';

@HiveType(typeId: 1)
class Plan extends HiveObject {
  @HiveField(0)
  @HiveField(1)
  String? name_plan;
  @HiveField(2)
  int? crossCountPlan;
  @HiveField(3)
  String? commentPlan;
  @HiveField(4)
  String? file;


  Plan({this.name_plan = '', required this.crossCountPlan, required this.commentPlan, required this.file});
}