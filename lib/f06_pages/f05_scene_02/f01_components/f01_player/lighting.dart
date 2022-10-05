import 'package:flutter/material.dart';

class Lighting  {

  late final double radius;
  late final double blurBorder;
  final Color color = Colors.transparent;
  Lighting(double width){
    radius = width * 1.5;
    blurBorder = width * 1.5;
  }
}