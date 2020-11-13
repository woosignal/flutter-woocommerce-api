import 'package:flutter/material.dart';

Widget buildTextFormStyle(double height, Widget child) {
  return Container(
    height: height * 0.8,
    margin: EdgeInsets.only(left: height / 4, right: height / 4, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xfff0f5fd),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(124, 116, 146, 0.2),
          blurRadius: 10.0, // has the effect of softening the shadow
          spreadRadius: 1.0, // has the effect of extending the shadow
          offset: Offset(
            0.0, // horizontal, move right 10
            10.0, // vertical, move down 10
          ),
        )
      ],
    ),
    child: Center(child: child),
  );
}
