import 'dart:developer';
import 'dart:io';

import 'package:cross_stitch_planner/contacts/hive_names.dart';
import 'package:cross_stitch_planner/models/new_plan/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'plan.dart';

class UpdatePlan extends StatefulWidget {
  UpdatePlan(this.name_plan, this.commentPlan, this.imageFile, this.key_plan);
  final int key_plan;
  String? name_plan;
  String? commentPlan;
  String? imageFile;
  final formKey = GlobalKey<FormState>();

  @override
  _UpdatePlanState createState() => _UpdatePlanState();
}

class _UpdatePlanState extends State<UpdatePlan> {
  int? crossCountPlan = 1;
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
                    widget.imageFile != null
                        ? SizedBox(
                      width: MediaQuery.of(context).size.width - 10,
                      height: 150,
                      child: TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Color(0xFFEDFAF9)),
                        ),
                        onPressed: () {
                          _getFromGallery();
                        },
                        icon: Container(
                            width: 150,
                            height: 150,
                            child:
                            Image.file(File(widget.imageFile.toString()))),
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
                            backgroundColor:
                            MaterialStateProperty.all(Color(0xFFEDFAF9),)),
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
                      autofocus: false,
                      cursorColor: Color(0xFF625F5F),
                      initialValue: widget.name_plan,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Название',
                        labelStyle: TextStyle(color: Color(0xFF625F5F)),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.name_plan = value;
                        });
                      },
                      validator: (val) {
                        return val!.trim().isEmpty
                            ? 'Название не введено'
                            : null;
                      },
                    ),
                    Container(
                      padding:EdgeInsets.only(bottom: 10, top: 10),
                      child: TextFormField(
                        autofocus: false,
                        maxLines: null,
                        cursorColor: Color(0xFF625F5F),
                        initialValue: widget.commentPlan,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Комментарий',
                          labelStyle: TextStyle(color: Color(0xFF625F5F)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.commentPlan = value == null ? '' : value;
                          });
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
      log('form is invalid');
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
        widget.imageFile = pickedFile.path;
      });
    }
  }

  void _onFormSubmit() {
    Box<Plan> contactsBox = Hive.box<Plan>(HiveBoxes.plan);
    contactsBox.put(widget.key_plan,Plan(
        name_plan: widget.name_plan,
        crossCountPlan: crossCountPlan!,
        commentPlan: widget.commentPlan,
        file: widget.imageFile
    ));
    Navigator.of(context).pop();
  }
}
