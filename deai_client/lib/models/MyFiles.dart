
import 'package:flutter/material.dart';

import '../constants.dart';

class Model {
  final String? svgSrc, title;
  final int? accuracy, percentage;
  final Color? color;

  Model({
    this.svgSrc,
    this.title,
    this.accuracy,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  Model(
    title: "Sentiment Analysis",
  accuracy: 85,
    svgSrc: "assets/icons/Documents.svg",
    
    color: primaryColor,
    percentage: 85,
  ),
 
];
