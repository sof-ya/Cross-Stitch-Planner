import 'dart:io';
import 'dart:math';

import 'package:cross_stitch_planner/contacts/hive_names.dart';
import 'package:cross_stitch_planner/models/new_process/process.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'result.dart';

class UpdateResult extends StatefulWidget {
  UpdateResult(
      this.name_result,
      this.comment_result,
      this.imageFile_result,
      this.nameAutor_result,
      this.startDate_result,
      this.finishDate_result,
      this.key_result);

  final int key_result;
  String? name_result;
  String? comment_result;
  String? imageFile_result;
  String? nameAutor_result;
  DateTime? startDate_result;
  DateTime? finishDate_result;
  final formKey = GlobalKey<FormState>();

  @override
  _UpdateResultState createState() => _UpdateResultState();
}

class _UpdateResultState extends State<UpdateResult> {
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
                  children: [
                    widget.imageFile_result != null
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
                                  child: Image.file(File(
                                      widget.imageFile_result.toString()))),
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
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        autofocus: false,
                        cursorColor: Color(0xFF625F5F),
                        initialValue: widget.name_result,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Название схемы',
                          labelStyle: TextStyle(color: Color(0xFF625F5F)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.name_result = value;
                          });
                        },
                        validator: (val) {
                          return val!.trim().isEmpty
                              ? 'Название схемы не введено'
                              : null;
                        },
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      cursorColor: Color(0xFF625F5F),
                      initialValue: widget.nameAutor_result,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Автор',
                        labelStyle: TextStyle(color: Color(0xFF625F5F)),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.nameAutor_result = value;
                        });
                      },
                      validator: (val) {
                        return val!.trim().isEmpty
                            ? 'Имя автора не введено'
                            : null;
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: TextFormField(
                        autofocus: false,
                        cursorColor: Color(0xFF625F5F),
                        initialValue: widget.comment_result,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Комментарий',
                          labelStyle: TextStyle(color: Color(0xFF625F5F)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.comment_result = value == null ? '' : value;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: DateTimeFormField(
                        dateTextStyle: TextStyle(color: Color(0xFF625F5F)),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Color(0xFF625F5F)),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Дата старта',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusColor: Color(0xFF625F5F),
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        initialValue: (widget.startDate_result==null?DateTime.now():widget.startDate_result),
                        onDateSelected: (DateTime value) {
                          widget.startDate_result = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: DateTimeFormField(
                        dateTextStyle: TextStyle(color: Color(0xFF625F5F)),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Color(0xFF625F5F)),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Дата финиша',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusColor: Color(0xFF625F5F),
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        initialValue: (widget.finishDate_result==null?DateTime.now():widget.finishDate_result),
                        onDateSelected: (DateTime value) {
                          widget.finishDate_result = value;
                        },
                      ),
                    ),
                    Container(
                      height: 60,
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(18.0),
                        minSize: MediaQuery.of(context).size.width - 10,
                        color: Color(0xFF625F5F),
                        child: Text(
                          'Сохранить',
                          style: TextStyle(color: Colors.white),
                        ),
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
        widget.imageFile_result = pickedFile.path;
      });
    }
  }

  void _onFormSubmit() {
    Box<Result> contactsBox = Hive.box<Result>(HiveBoxes.result);
    contactsBox.put(
        widget.key_result,
        Result(
            name_shema: widget.name_result,
            comment: widget.comment_result,
            file: widget.imageFile_result,
            startDate: widget.startDate_result,
            finishDate: widget.finishDate_result,
            name_autor: widget.nameAutor_result));
    Navigator.of(context).pop();
  }
}
