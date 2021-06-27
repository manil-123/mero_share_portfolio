import 'package:flutter/material.dart';
import 'package:mero_share_portfolio/models/share_data.dart';
import 'package:mero_share_portfolio/utils/databasehelper.dart';

class PieData {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ShareData> _shareDataList = [];
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

  void getData() async {
    _shareDataList = await databaseHelper.getShareDataList();
  }
}

class Data {
  String name;
  double percent;
  Color color;

  Data({this.name, this.percent, this.color});
}
