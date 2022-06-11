import 'package:hive/hive.dart';

part 'statistic.g.dart';

@HiveType(typeId: 2)

class Statistic extends HiveObject {
  @HiveField(1)
  String? name_shema;
  @HiveField(2)
  DateTime? date;
  @HiveField(3)
  int? cross_count;
  @HiveField(4)
  String? file;


  Statistic({this.name_shema = '', required this.date, required this.cross_count, required this.file});
}
