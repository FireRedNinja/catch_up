import 'package:flutter/material.dart';

ThemeData gettheme(String page) {
  MaterialColor primarySwatch;
  switch (page) {
    case "Hacker News":
      primarySwatch = Colors.deepOrange;
      break;
    case "GitHub":
      primarySwatch = Colors.blueGrey;
      break;
    case "Product Hunt":
      primarySwatch = Colors.deepOrange;
      break;
    default:
  }
  return ThemeData(
    primarySwatch: primarySwatch,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
