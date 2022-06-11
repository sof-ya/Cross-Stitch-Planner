import 'dart:io';

import 'package:cross_stitch_planner/contacts/hive_names.dart';
import 'package:cross_stitch_planner/models/statistic/statistic.dart';
import 'package:cross_stitch_planner/statistic_page.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateStatistic extends StatefulWidget {
  UpdateStatistic(this.nameProc_statistic, this.date_statistic,
      this.crossCount_statistic, this.file_statistic, this.key_statistic);

  final int key_statistic;
  String? nameProc_statistic;
  late DateTime date_statistic;
  int? crossCount_statistic;
  String? file_statistic;
  final formKey = GlobalKey<FormState>();

  @override
  State<UpdateStatistic> createState() => _UpdateStatisticState();
}

class _UpdateStatisticState extends State<UpdateStatistic> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDFAF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.file_statistic != null
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width - 10,
                            height: 150,
                            child: TextButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFEDFAF9)),
                              ),
                              onPressed: () {
                                _getFromGallery();
                              },
                              icon: Container(
                                  width: 150,
                                  height: 150,
                                  child: Image.file(
                                      File(widget.file_statistic.toString()))),
                              label: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.photo_camera,
                                        color: Color(0XFF625F5F)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Добавить фото",
                                        style:
                                            TextStyle(color: Color(0xFF625F5F)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width - 10,
                            height: 150,
                            child: TextButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFEDFAF9))),
                              onPressed: () {
                                _getFromGallery();
                              },
                              icon: Container(
                                  width: 150,
                                  height: 150,
                                  child: Image.asset('assets/icons/logo.png')),
                              label: Row(
                                children: [
                                  Icon(Icons.photo_camera,
                                      color: Color(0XFF625F5F)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text("Добавить фото",
                                        style: TextStyle(
                                            color: Color(0xFF625F5F))),
                                  )
                                ],
                              ),
                            ),
                          ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      cursorColor: Color(0xFF625F5F),
                      initialValue: widget.nameProc_statistic,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Название процесса',
                        labelStyle: TextStyle(color: Color(0xFF625F5F)),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.nameProc_statistic = value;
                        });
                      },
                      validator: (val) {
                        return val!.trim().isEmpty
                            ? 'Имя автора не введено'
                            : null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: DateTimeFormField(
                        dateTextStyle: TextStyle(color: Color(0xFF625F5F)),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Color(0xFF625F5F)),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Дата',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusColor: Color(0xFF625F5F),
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        initialValue: widget.date_statistic,
                        onDateSelected: (DateTime value) {
                          widget.date_statistic = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        cursorColor: Color(0xFF625F5F),
                        initialValue: widget.crossCount_statistic.toString(),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Количество стежков',
                          labelStyle: TextStyle(color: Color(0xFF625F5F)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.crossCount_statistic = int.parse(value);
                          });
                        },
                        validator: (val) {
                          return val!.trim().isEmpty
                              ? 'Количество стежков не введено'
                              : null;
                        },
                      ),
                    ),
                    Container(
                      height: 60,
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(18.0),
                        minSize: MediaQuery.of(context).size.width - 10,
                        color: Color(0xFF625F5F),
                        child: Text('Сохранить', style: TextStyle(color: Colors.white),),
                        onPressed: _validateAndSave,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      _onFormSubmit();
    } else {
      print('form is invalid');
    }
  }

  void _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        widget.file_statistic = pickedFile.path;
      });
    }
  }

  void _onFormSubmit() {
    Box<Statistic> contactsBox = Hive.box<Statistic>(HiveBoxes.statistic);
    contactsBox.put(
        widget.key_statistic,
        Statistic(
            name_shema: widget.nameProc_statistic,
            date: widget.date_statistic,
            cross_count: widget.crossCount_statistic,
            file: widget.file_statistic));
    Navigator.of(context).pop();
  }
}
