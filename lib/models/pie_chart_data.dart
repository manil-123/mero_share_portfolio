import 'package:flutter/material.dart';

class PieChartData {
  static List<Data> data = [
    Data(
      name: 'Red',
      percent: 30,
      color: Colors.red,
    ),
    Data(
      name: 'Blue',
      percent: 20,
      color: Colors.blue,
    ),
    Data(
      name: 'Green',
      percent: 15,
      color: Colors.green,
    ),
    Data(
      name: 'Yellow',
      percent: 35,
      color: Colors.yellow,
    )
  ];
}

class Data {
  String name;
  double percent;
  Color color;

  Data({this.name, this.percent, this.color});
}
