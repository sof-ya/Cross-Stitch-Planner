import 'dart:developer';
import 'dart:io';

import 'package:cross_stitch_planner/contacts/hive_names.dart';
import 'package:cross_stitch_planner/homepage.dart';
import 'package:cross_stitch_planner/models/statistic/statistic.dart';
import 'package:cross_stitch_planner/models/statistic/update_statistic.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  late Iterable<Statistic> itemBoxFiltred;
  final hiveBox = Hive.box<Statistic>('statistic_box');
  Box<Statistic> itemBox = Hive.box<Statistic>("statistic_box");
  late List list;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDFAF9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BackButton(onPressed: () {
                        Navigator.pop(context);
                      }),
                      Text("Статистика",
                          style: GoogleFonts.alegreyaSansSc(
                            textStyle: TextStyle(
                                fontSize: 24, color: Color(0xFF625F5F)),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        iconSize: 30,
                        color: Color(0xFFC4C4C4),
                        onPressed: () {
                          showDialog(context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Информация'),
                                  content: Container(
                                    height: MediaQuery.of(context).size.width - 240,
                                    child: Column(
                                      children: [
                                        Text("✾ Чтобы удалить элемент, сделайте свайп вправо или влево\n"),
                                        Text("✾ Чтобы отредактировать элемент, удерживайте палец")
                                      ],
                                    ),
                                  ),

                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    new FlatButton(
                                      child: new Text("Понятно"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Statistic>(HiveBoxes.statistic).listenable(),
                    builder: (context, Box<Statistic> box, _) {
                      if (box.values.isEmpty)
                        return Center(
                          child: Text("Ничего не найдено"),
                        );
                      return ListView.builder(
                        //reverse: true,
                          itemCount: box.values.length,
                          itemBuilder: (context, index) {
                            Statistic? res = box.getAt(box.values.length - index - 1);
                            return Column(
                              children: [
                                Dismissible(
                                  background: Container(
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Icon(Icons.delete,
                                              size: 30, color: Colors.white),
                                        ),
                                        Text(
                                          "Удалить",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                  key: UniqueKey(),
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Подтверждение"),
                                          content: Text(
                                              "Вы точно хотите удалить статистику за этот день?"),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () => {
                                                      res?.delete(),
                                                      Navigator.of(context)
                                                          .pop()
                                                    },
                                                child: const Text("Удалить")),
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("Отмена"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 10,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              135,
                                          child: ListTile(

                                            title: Text(res?.name_shema ?? '',
                                                style: TextStyle(fontSize: 20)),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Количество стежков: ",
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                    Text(
                                                        (res?.cross_count ?? '')
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ],
                                                ),
                                                Text(DateFormat('dd.MM.yyyy')
                                                    .format(res!.date!))
                                              ],
                                            ),
                                            onLongPress: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateStatistic(
                                                              res.name_shema,
                                                              res.date
                                                                  as DateTime,
                                                              res.cross_count,
                                                              res.file,
                                                              res.key)));
                                            },
                                          ),
                                        ),
                                        res.file == null
                                            ? Container()
                                            : Container(
                                                padding: EdgeInsets.all(5),
                                                height: 120.0,
                                                width: 120.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                ),
                                                child: Image.file(
                                                  File(res.file as String),
                                                  fit: BoxFit.cover,
                                                )),
                                      ],
                                    ),
                                  ),
                                ),
                                (box.length - 1 == index)?
                                Container()
                                    : Divider(
                                    height: 10,
                                    color: Color(0xFF828282),
                                    thickness: 2,
                                    endIndent: 8)
                              ],
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

//bool _decideWhichDayToEnable(DateTime day) {
//  if ((day.isAfter(DateTime.now().subtract(Duration(days: 10))) &&
//    day.isBefore(DateTime.now().add(Duration(days: 0))))) {
//  return true;
//  }
//return false;
//}
}
