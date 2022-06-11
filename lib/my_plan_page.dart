import 'dart:io';

import 'package:cross_stitch_planner/contacts/hive_names.dart';
import 'package:cross_stitch_planner/models/new_plan/add_new_plan.dart';
import 'package:cross_stitch_planner/models/new_plan/plan.dart';
import 'package:cross_stitch_planner/models/new_plan/update_plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({Key? key}) : super(key: key);

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
                      Text("Мои запасы",
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
                                    height: MediaQuery.of(context).size.width - 160,
                                    child: Column(
                                      children: [
                                        Text("✾ Чтобы добавить новый элемент, нажмите + в правом верхнем углу\n"),
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
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        iconSize: 30,
                        color: Color(0xFFC4C4C4),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddPlan()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Plan>(HiveBoxes.plan).listenable(),
                    builder: (context, Box<Plan> box, _) {
                      if (box.values.isEmpty)
                        return Center(
                          child: Text("Список запасов пуст"),
                        );
                      return ListView.builder(
                          itemCount: box.values.length,
                          itemBuilder: (context, index) {
                            Plan? res = box.getAt(index);
                            return Column(
                              children: [
                                Dismissible(
                                  background: Container(
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Icon(Icons.delete, size: 30, color: Colors.white),
                                        ),
                                        Text(
                                          "Удалить",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                                              "Вы точно хотите удалить " +
                                                  (res?.name_plan as String) +
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
                                  },
                                  child: SizedBox(
                                    width:  MediaQuery.of(context).size.width - 10,
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
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(8.0)),
                                                ),
                                                child: Image.file(File(res?.file as String),
                                                  fit: BoxFit.cover,
                                                )),
                                        Container(
                                          width: MediaQuery.of(context).size.width - 135,
                                          child: ListTile(
                                            title: Text(res?.name_plan ?? '',
                                                style: TextStyle(fontSize: 20)),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(res?.commentPlan ?? ''),
                                              ],
                                            ),
                                            onLongPress: ()
                                            {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdatePlan(res?.name_plan, res?.commentPlan, res?.file, res?.key)));
                                            },
                                          ),
                                        ),
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
}
