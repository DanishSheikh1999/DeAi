import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration kBoxDecoration = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(16, 16, 20, 1),
      Color.fromRGBO(8, 8, 10, 1),
      Color.fromRGBO(4, 4, 5, 1),
      Colors.black
    ],
    stops: [0, .3, .5, 1],
  ),
);
