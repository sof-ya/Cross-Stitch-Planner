import 'dart:io';

import 'package:cross_stitch_planner/contacts/hive_names.dart';
import 'package:cross_stitch_planner/models/new_process/process.dart';
import 'package:date_field/date_field.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'process.dart';

class UpdateProc extends StatefulWidget {
  UpdateProc(this.name_proc, this.crossCount_proc, this.comment_proc,
      this.imageFile_proc, this.startDate_proc, this.name_autor_proc, this.key_proc);

  final int key_proc;
  String? name_proc;
  int? crossCount_proc;
  String? comment_proc;
  String? imageFile_proc;
  DateTime startDate_proc;
  String? name_autor_proc;
  final formKey = GlobalKey<FormState>();

  @override
  _UpdateProcState createState() => _UpdateProcState();
}

class _UpdateProcState extends State<UpdateProc> {
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
                    widget.imageFile_proc != null
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
                                      File(widget.imageFile_proc.toString()))),
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
                        initialValue: widget.name_proc,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Название схемы',
                          labelStyle: TextStyle(color: Color(0xFF625F5F)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.name_proc = value;
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
                      initialValue: widget.name_autor_proc,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Автор',
                        labelStyle: TextStyle(color: Color(0xFF625F5F)),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.name_autor_proc = value;
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
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        cursorColor: Color(0xFF625F5F),
                        initialValue: widget.crossCount_proc.toString(),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Количество стежков',
                          labelStyle: TextStyle(color: Color(0xFF625F5F)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.crossCount_proc = int.parse(value);
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
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        autofocus: false,
                        maxLines: null,
                        cursorColor: Color(0xFF625F5F),
                        initialValue: widget.comment_proc,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Комментарий',
                          labelStyle: TextStyle(color: Color(0xFF625F5F)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.comment_proc = value == null ? '' : value;
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
                        initialValue: (widget.startDate_proc==null?DateTime.now():widget.startDate_proc),
                        onDateSelected: (DateTime value) {
                          widget.startDate_proc = value;
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
        widget.imageFile_proc = pickedFile.path;
      });
    }
  }

  void _onFormSubmit() {
    Box<Process> contactsBox = Hive.box<Process>(HiveBoxes.proc);
    contactsBox.put(
        widget.key_proc,
        Process(
            name_shema: widget.name_proc,
            crossCount: widget.crossCount_proc,
            comment: widget.comment_proc,
            file: widget.imageFile_proc,
            startDate: widget.startDate_proc,
            name_autor: widget.name_autor_proc,
            finishDate: null));
    Navigator.of(context).pop();
  }
}
