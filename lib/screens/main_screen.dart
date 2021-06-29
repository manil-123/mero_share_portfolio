import 'package:flutter/material.dart';
import 'package:mero_share_portfolio/models/share_data_provider.dart';
import 'package:mero_share_portfolio/widgets/pie_chart.dart';
import 'dashboard.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
            // Row(
            //   children: [
            //     Container(
            //       width: MediaQuery.of(context).size.width / 1.5,
            //       padding: EdgeInsets.all(5),
            //       height: 200,
            //       child: PieChart(
            //         PieChartData(
            //           sections: getSections(),
            //         ),
            //       ),
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(16),
            //           child: IndicatorsWidget(),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      myCard(
                        'Dashboard',
                        '',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashBoard(),
                            ),
                          );
                        },
                      ),
                      myCard(
                        'Overall Stocks',
                        '${Provider.of<ShareDataProvider>(context).shareDataCount}',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PieChartWidget(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      myCard(
                        'Total Investment',
                        'Rs. ${Provider.of<ShareDataProvider>(context).totalInvestment}',
                        () {},
                      ),
                      myCard(
                        'Total Profit',
                        'Rs. ${Provider.of<ShareDataProvider>(context).totalProfit}',
                        () {},
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

  Widget myCard(String heading, String value, Function onClick) {
    return Expanded(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(15),
        child: InkWell(
          onTap: onClick,
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
