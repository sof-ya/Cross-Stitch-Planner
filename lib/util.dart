import 'package:cross_stitch_planner/models/statistic/statistic.dart';
import 'package:intl/intl.dart';

class Util
{
  static String makeString(DateTime? obj) {
    String outDate = DateFormat('dd.MM.yyyy').format(obj!);
        return outDate;
  }
}