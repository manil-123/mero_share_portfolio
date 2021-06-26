import 'package:flutter/material.dart';
import 'package:mero_share_portfolio/models/data_list.dart';
import 'package:mero_share_portfolio/models/pie_chart_sections.dart';
import 'package:mero_share_portfolio/models/share_data.dart';
import 'package:mero_share_portfolio/models/share_data_provider.dart';
import 'package:mero_share_portfolio/widgets/piechart_indicator.dart';
// import 'package:pie_chart/pie_chart.dart';
import 'dashboard.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> companyNames = [];
  Map<String, String> companySectorData = ListDataModel.companySectorData;
  List<ShareData> shareDataList = [];
  Map<String, double> dataMap = Map();
  List<Color> colorList = [];
  // Colors.red,
  // Colors.yellow,
  // Colors.green,
  // Colors.redAccent,
  // Colors.blueGrey,
  // Colors.purple,
  // Colors.black12,
  // Colors.greenAccent,
  // Colors.pink,

  // Widget pieChart() {
  //   return PieChart(
  //     dataMap: dataMap,
  //     initialAngleInDegree: 0,
  //     animationDuration: Duration(milliseconds: 800),
  //     chartType: ChartType.disc,
  //     chartRadius: MediaQuery.of(context).size.width / 2.2,
  //     ringStrokeWidth: 32,
  //     colorList: colorList,
  //     chartLegendSpacing: 20,
  //     centerText: "Stocks",
  //     legendOptions: LegendOptions(
  //       showLegendsInRow: false,
  //       legendPosition: LegendPosition.right,
  //       showLegends: true,
  //       legendShape: BoxShape.circle,
  //       legendTextStyle: TextStyle(
  //         fontWeight: FontWeight.bold,
  //         fontSize: 8,
  //         color: Colors.black87,
  //       ),
  //     ),
  //     chartValuesOptions: ChartValuesOptions(
  //       showChartValueBackground: true,
  //       showChartValues: false,
  //       showChartValuesInPercentage: true,
  //       showChartValuesOutside: false,
  //       decimalPlaces: 1,
  //     ),
  //   );
  // }

  // Future buildPieChart() {
  //   this.shareDataList =
  //       Provider.of<ShareDataProvider>(context, listen: false).shareData;
  //   if (shareDataList == []) {
  //     dataMap.putIfAbsent("null", () => 1);
  //     colorList.add(Colors.red);
  //   }
  //   print("dataMap $dataMap");
  //   return null;
  // }

  // @override
  // void initState() {
  //   buildPieChart();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Portfolio'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.lightBlueAccent,
              Colors.blueAccent,
            ],
          ),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Overall Stocks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: EdgeInsets.all(5),
            //   child: FutureBuilder(
            //     future: buildPieChart(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return pieChart();
            //       } else {
            //         return SizedBox(
            //           width: 50,
            //           height: 50,
            //           child: CircularProgressIndicator(
            //             strokeWidth: 2,
            //             backgroundColor: Colors.red,
            //           ),
            //         );
            //       }
            //     },
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: EdgeInsets.all(5),
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: getSections(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: IndicatorsWidget(),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashBoard(),
                                ),
                              );
                            },
                            splashColor: Colors.greenAccent,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text('My DashBoard'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(''),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {},
                            splashColor: Colors.greenAccent,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Overall Stocks',
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        '${Provider.of<ShareDataProvider>(context).shareDataCount}'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {},
                            splashColor: Colors.greenAccent,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Total Investment',
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        'Rs. ${Provider.of<ShareDataProvider>(context).totalInvestment}'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {},
                            splashColor: Colors.greenAccent,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Total Profit',
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        'Rs. ${Provider.of<ShareDataProvider>(context).totalProfit}'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myCard(String heading, String value) {
    return Expanded(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(15),
        child: InkWell(
          onTap: () {},
          splashColor: Colors.greenAccent,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    heading,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  value == "0.0"
                      ? SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            backgroundColor: Colors.red,
                          ),
                        )
                      : Text('$value')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
