import 'dart:async';
import 'dart:developer';

import 'package:cross_stitch_planner/about.dart';
import 'package:cross_stitch_planner/contacts/hive_names.dart';
import 'package:cross_stitch_planner/models/statistic/statistic.dart';
import 'package:cross_stitch_planner/my_plan_page.dart';
import 'package:cross_stitch_planner/my_process_page.dart';
import 'package:cross_stitch_planner/my_results_page.dart';
import 'package:cross_stitch_planner/statistic_page.dart';
import 'package:cross_stitch_planner/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateFormat format = DateFormat.yMd();
  var time = DateFormat.Hm().format(DateTime.now());
  var date = DateFormat.yMd().format(DateTime.now());
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        time = DateFormat.Hm().format(DateTime.now());
        date = DateFormat.yMd().format(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color(0xFFEDFAF9),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Меню",
                    style: GoogleFonts.alegreyaSansSc(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                  )),
            ),
            ListTile(
                title: Text(
                  "    Мои процессы",
                  style: GoogleFonts.alegreyaSansSc(
                      textStyle:
                          TextStyle(fontSize: 20, color: Color(0xFF625F5F))),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProcessesPage()));
                }),
            ListTile(
                title: Text(
                  "    Мои запасы",
                  style: GoogleFonts.alegreyaSansSc(
                      textStyle:
                          TextStyle(fontSize: 20, color: Color(0xFF625F5F))),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PlanPage()));
                }),
            ListTile(
                title: Text(
                  "    Мои итоги",
                  style: GoogleFonts.alegreyaSansSc(
                      textStyle:
                          TextStyle(fontSize: 20, color: Color(0xFF625F5F))),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResultPage()));
                }),
            ListTile(
                title: Text(
                  "    Статистика",
                  style: GoogleFonts.alegreyaSansSc(
                      textStyle:
                          TextStyle(fontSize: 20, color: Color(0xFF625F5F))),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => StatisticPage()));
                }),
            ListTile(
                title: Text(
                  "    О приложении",
                  style: GoogleFonts.alegreyaSansSc(
                      textStyle:
                          TextStyle(fontSize: 20, color: Color(0xFF625F5F))),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AboutPage()));
                }),
          ],
        ),
      ),
      body: Container(
          height: double.infinity,
          child: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("img/cross_stitch_planner_background.jpg"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
                child: Center(
              child: Column(
                children: [
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.menu,
                                  color: CupertinoColors.white),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                          ]),
                    );
                  }),
                  Column(
                    children: [
                      Text(
                        time.toString(),
                        style: GoogleFonts.alegreyaSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 70,
                                color: Colors.white,
                                shadows: [
                              Shadow(
                                  offset: Offset(-1.5, -1.5),
                                  color: Color(0xFF625F5F)),
                              Shadow(
                                  offset: Offset(1.5, -1.5),
                                  color: Color(0xFF625F5F)),
                              Shadow(
                                  offset: Offset(1.5, 1.5),
                                  color: Color(0xFF625F5F)),
                              Shadow(
                                  offset: Offset(-1.5, 1.5),
                                  color: Color(0xFF625F5F))
                            ])),
                      ),
                      Text(
                        date.toString(),
                        style: GoogleFonts.alegreyaSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                                shadows: [
                              Shadow(
                                  offset: Offset(-1.5, -1.5),
                                  color: Color(0xFF625F5F)),
                              Shadow(
                                  offset: Offset(1.5, -1.5),
                                  color: Color(0xFF625F5F)),
                              Shadow(
                                  offset: Offset(1.5, 1.5),
                                  color: Color(0xFF625F5F)),
                              Shadow(
                                  offset: Offset(-1.5, 1.5),
                                  color: Color(0xFF625F5F))
                            ])),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Text('    Стежков за сегодня: ',
                                style: GoogleFonts.alegreyaSans(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.white,
                                        shadows: [
                                      Shadow(
                                          offset: Offset(-1.5, -1.5),
                                          color: Color(0xFF625F5F)),
                                      Shadow(
                                          offset: Offset(1.5, -1.5),
                                          color: Color(0xFF625F5F)),
                                      Shadow(
                                          offset: Offset(1.5, 1.5),
                                          color: Color(0xFF625F5F)),
                                      Shadow(
                                          offset: Offset(-1.5, 1.5),
                                          color: Color(0xFF625F5F))
                                    ]))),
                          ),
                          ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<Statistic>(HiveBoxes.statistic)
                                      .listenable(),
                              builder: (context, Box<Statistic> box, _) {
                                var values = box.values.where((element) => Util.makeString(element.date) == Util.makeString(DateTime.now()));
                                var stitches = values.fold(0, (int previousValue, element) => previousValue+element.cross_count!);
                                return Center(
                                        child: Text(stitches.toString(),
                                            style: GoogleFonts.alegreyaSans(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                          offset: Offset(-1.5, -1.5),
                                                          color: Color(0xFF625F5F)),
                                                      Shadow(
                                                          offset: Offset(1.5, -1.5),
                                                          color: Color(0xFF625F5F)),
                                                      Shadow(
                                                          offset: Offset(1.5, 1.5),
                                                          color: Color(0xFF625F5F)),
                                                      Shadow(
                                                          offset: Offset(-1.5, 1.5),
                                                          color: Color(0xFF625F5F))
                                                    ]))),
                                      );}
                              ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ))
          ])),
    );
  }
}
