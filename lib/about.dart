import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEDFAF9),
        body: SafeArea(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: Row(
                      children: [
                        BackButton(onPressed: () {
                          Navigator.pop(context);
                        }),
                        Text("О приложении",
                            style: GoogleFonts.alegreyaSansSc(
                              textStyle: TextStyle(
                                  fontSize: 24, color: Color(0xFF625F5F)),
                            )),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Версия: 1.2 Бета",
                                  style: GoogleFonts.alegreyaSansSc(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF625F5F)),
                                  ))
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text("Связь с разработчиком:",
                                    style: GoogleFonts.alegreyaSansSc(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF625F5F)),
                                    )),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 30),
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Telegram:  kulikova_31",
                                          style: GoogleFonts.alegreyaSansSc(
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF625F5F)),
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Почта: sofja.kulickowa@yandex.ru",
                                          style: GoogleFonts.alegreyaSansSc(
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF625F5F)),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 66,
                            width: 285,
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(20)),
                                  depth: 5,
                                  intensity: 8,
                                  color: Color(0xFFEDFAF9)),
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Электронный вышивальный',
                                            style: GoogleFonts.alegreyaSansSc(
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF625F5F)),
                                            ),
                                          ),
                                          Text(
                                            'ежедневник',
                                            style: GoogleFonts.alegreyaSansSc(
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF625F5F)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          image: DecorationImage(
                              image: AssetImage("img/fox.jpg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            'Для комфортной работы с приложением рекомендуется',
                            style: GoogleFonts.alegreyaSansSc(
                              textStyle:
                                  TextStyle(fontSize: 12, color: Color(0xFF625F5F)),
                            ),
                          ),
                          Text(
                            'пользоваться электронными схемами для вышивания',
                            style: GoogleFonts.alegreyaSansSc(
                              textStyle:
                              TextStyle(fontSize: 12, color: Color(0xFF625F5F)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
