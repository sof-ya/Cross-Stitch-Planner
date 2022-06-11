import 'package:cross_stitch_planner/contacts/hive_names.dart';
import 'package:cross_stitch_planner/homepage.dart';
import 'package:cross_stitch_planner/models/new_plan/plan.dart';
import 'package:cross_stitch_planner/models/new_process/process.dart';
import 'package:cross_stitch_planner/models/results/result.dart';
import 'package:cross_stitch_planner/models/statistic/statistic.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  initializeDateFormatting('ru', null);
  await Hive.initFlutter();
  Hive.registerAdapter(ProcessAdapter());
  Hive.registerAdapter(PlanAdapter());
  Hive.registerAdapter(StatisticAdapter());
  Hive.registerAdapter(ResultAdapter());
  await Hive.openBox<Process>(HiveBoxes.proc);
  await Hive.openBox<Plan>(HiveBoxes.plan);
  await Hive.openBox<Statistic>(HiveBoxes.statistic);
  await Hive.openBox<Result>(HiveBoxes.result);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage()
    );
  }
}
