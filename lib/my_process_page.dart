import 'dart:developer';
import 'dart:io';

import 'package:cross_stitch_planner/contacts/hive_names.dart';
import 'package:cross_stitch_planner/homepage.dart';
import 'package:cross_stitch_planner/models/new_plan/update_plan.dart';
import 'package:cross_stitch_planner/models/new_process/add_new_process.dart';
import 'package:cross_stitch_planner/models/new_process/process.dart';
import 'package:cross_stitch_planner/models/new_process/update_process.dart';
import 'package:cross_stitch_planner/models/results/result.dart';
import 'package:cross_stitch_planner/models/statistic/new_statistic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ProcessesPage extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _ProcessesPageState createState() => _ProcessesPageState();
}

class _ProcessesPageState extends State<ProcessesPage> {
  String? name_result;
  String? comment_result;
  String? image_result;
  String? name_autor;
  DateTime? startDate;
  final _formKey = GlobalKey<FormState>();

  @override
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
                      Text("Мои процессы",
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Информация'),
                                  content: Container(
                                    height:
                                        MediaQuery.of(context).size.width - 20,
                                    child: Column(
                                      children: [
                                        Text(
                                            "✾ Чтобы добавить новый элемент, нажмите + в правом верхнем углу\n"),
                                        Text(
                                            "✾ Чтобы удалить элемент, сделайте свайп вправо \n"),
                                        Text(
                                            "✾ Чтобы переместить элемент в раздел Мои итоги, сделайте свайп влево\n"),
                                        Text(
                                            "✾ Чтобы добавить статистику для процесса, нажмите на нужный элемент\n"),
                                        Text(
                                            "✾ Чтобы отредактировать элемент, удерживайте палец")
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
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        iconSize: 30,
                        color: Color(0xFFC4C4C4),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddProc()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Process>(HiveBoxes.proc).listenable(),
                    builder: (context, Box<Process> box, _) {
                      if (box.values.isEmpty)
                        return Center(
                          child: Text("Список процессов пуст"),
                        );
                      return ListView.builder(
                          itemCount: box.values.length,
                          itemBuilder: (context, index) {
                            Process? res = box.getAt(index);
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
                                  secondaryBackground: Container(
                                    color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Icon(Icons.insert_emoticon,
                                              size: 30, color: Colors.white),
                                        ),
                                        Text(
                                          "Завершить",
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
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Подтверждение"),
                                            content: Text(
                                                "Вы точно хотите удалить " +
                                                    (res?.name_shema
                                                        as String) +
                                                    "?"),
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
                                    } else {
                                      return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Подтверждение"),
                                            content: Text(
                                                "Вы точно хотите завершить процесс " +
                                                    (res?.name_shema
                                                        as String) +
                                                    "?"),
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () => {
                                                        Navigator.of(context)
                                                            .pop(),
                                                        name_result =
                                                            res?.name_shema,
                                                        comment_result =
                                                            res?.comment,
                                                        image_result =
                                                            res?.file,
                                                        startDate =
                                                            res?.startDate,
                                                        DateTime.now(),
                                                        name_autor =
                                                            res?.name_autor,
                                                        _onFormSubmit(),
                                                        res?.delete(),
                                                      },
                                                  child:
                                                      const Text("Завершить")),
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
                                    }
                                  },
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 10,
                                    child: Row(
                                      children: [
                                        res?.file == null
                                            ? Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    height: 120.0,
                                                    width: 120.0,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'assets/icons/logo.png'))),
                                                  ),
                                                ],
                                              )
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
                                                  File(res?.file as String),
                                                  fit: BoxFit.cover,
                                                )),
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
                                                Text("Автор: " + (res?.name_autor ?? ''),
                                                    style: TextStyle(
                                                        fontSize: 15)),
                                                Text("Количество стежков: " + (res?.crossCount ?? '')
                                                    .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15)),
                                                res?.startDate == null?Text("Старт: Введите дату",
                                                    style: TextStyle(
                                                        fontSize: 15)):
                                                Text("Старт: " + (DateFormat('dd.MM.yyyy')
                                                    .format(res?.startDate as DateTime))
                                                    .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15)),
                                                Text(res?.comment ?? ''),
                                              ],
                                            ),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          newStatistic(res?.name_shema)));
                                            },
                                            onLongPress: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateProc(
                                                              res?.name_shema,
                                                              res?.crossCount,
                                                              res?.comment,
                                                              res?.file,
                                                              (res?.startDate==null?DateTime.now():res?.startDate) as DateTime,
                                                              res?.name_autor,
                                                              res?.key)));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                (box.length - 1 == index)
                                    ? Container()
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

  void _onFormSubmit() {
    Box<Result> contactsBox = Hive.box<Result>(HiveBoxes.result);
    contactsBox.add(Result(
        name_shema: name_result!, comment: comment_result, file: image_result, startDate: startDate, name_autor: name_autor, finishDate: DateTime.now()));
    Navigator.of(context).pop();
  }
}
