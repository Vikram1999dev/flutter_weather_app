// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:weather_app/home.dart';
import 'package:weather_app/weather.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Weather App',
      home: Home(),
      routes: {
        Weather.routeName: (ctx) => Weather(),
      },
    ),
  );
}
