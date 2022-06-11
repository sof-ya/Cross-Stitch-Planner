import 'dart:io';

import 'package:cross_stitch_planner/contacts/hive_names.dart';
import 'package:cross_stitch_planner/models/statistic/statistic.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class newStatistic extends StatefulWidget {
  newStatistic(this.name, {Key? key}) : super(key: key);
  final String? name;
  final formKey = GlobalKey<FormState>();

  @override
  State<newStatistic> createState() => _newStatisticState();
}

class _newStatisticState extends State<newStatistic> {
  late DateTime date;
  int? crossCount;
  String? imageFile;
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
                    imageFile != null
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
                                  child:
                                      Image.file(File(imageFile.toString()))),
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
                    DateTimeFormField(
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
                      onDateSelected: (DateTime value) {
                        date = value;
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        cursorColor: Color(0xFF625F5F),
                        initialValue: '',
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Количество стежков',
                          labelStyle: TextStyle(color: Color(0xFF625F5F)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            crossCount = int.parse(value);
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
        imageFile = pickedFile.path;
      });
    }
  }

  void _onFormSubmit() {
    Box<Statistic> contactsBox = Hive.box<Statistic>(HiveBoxes.statistic);
    contactsBox.add(Statistic(
        name_shema: widget.name,
        date: date,
        cross_count: crossCount!,
        file: imageFile));
    Navigator.of(context).pop();
  }
}
