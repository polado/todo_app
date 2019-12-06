import 'dart:ui';

import 'package:flutter/material.dart';

import 'core/models/color_data.dart';

class MyColors {
  static List<ColorData> categoryColors = [
    new ColorData(color: Colors.redAccent, name: "redAccent"),
    new ColorData(color: Colors.blueAccent, name: "blueAccent"),
    new ColorData(color: Colors.greenAccent, name: "greenAccent"),
    new ColorData(color: Colors.orangeAccent, name: "orangeAccent"),
    new ColorData(color: Colors.purpleAccent, name: "purpleAccent"),
    new ColorData(color: Colors.amberAccent, name: "amberAccent"),
    new ColorData(color: Colors.indigoAccent, name: "indigoAccent"),
    new ColorData(color: Colors.brown, name: "brown"),
    new ColorData(color: Colors.deepOrangeAccent, name: "deepOrangeAccent"),
    new ColorData(color: Colors.deepPurpleAccent, name: "deepPurpleAccent"),
  ];

  static Color getColor(String color) {
    switch (color) {
      case 'redAccent':
        return Colors.redAccent;
      case 'greenAccent':
        return Colors.greenAccent;
      case 'blueAccent':
        return Colors.blueAccent;
      case 'orangeAccent':
        return Colors.orangeAccent;
      case 'deepOrangeAccent':
        return Colors.deepOrangeAccent;
      case 'purpleAccent':
        return Colors.purpleAccent;
      case 'deepPurpleAccent':
        return Colors.deepPurpleAccent;
      case 'amberAccent':
        return Colors.amberAccent;
      case 'indigoAccent':
        return Colors.indigoAccent;
      case 'brown':
        return Colors.brown;
      default:
        return Colors.blueGrey;
    }
  }
}
