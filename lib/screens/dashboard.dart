import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_share_portfolio/models/models.dart';
import 'package:mero_share_portfolio/models/share_data.dart';
import 'package:mero_share_portfolio/models/share_data_provider.dart';
import 'package:mero_share_portfolio/screens/share_details.dart';
import 'package:mero_share_portfolio/services/data_service.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'add_details.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<NepseShareDataModel> nepseDataList = [];
  DataService dataService = DataService();
  List<ShareData> shareDataList = [];

  Future<String> getPriceData(String companyName) async {
    nepseDataList = await dataService.fetchShareData(http.Client());
    double price;
    for (int i = 0; i < nepseDataList.length; i++)
      if (companyName == nepseDataList[i].companyName) {
        price = nepseDataList[i].closingPrice;
      }
    return price.toString();
  }

  // void updateShareDataTable() {
  //   Provider.of<ShareDataProvider>(context, listen: false).getShareData();
  //   this.shareDataList =
  //       Provider.of<ShareDataProvider>(context, listen: false).shareData;
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   updateShareDataTable();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DashBoard')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columnSpacing: 6.0,
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(
                        label: Text(
                          'Scrip',
                          style: TextStyle(fontSize: 14),
                        ),
                        numeric: false),
                    DataColumn(
                        label: Text('LTP', style: TextStyle(fontSize: 14)),
                        numeric: false),
                    DataColumn(
                        label: Text('Quantity', style: TextStyle(fontSize: 14)),
                        numeric: false),
                    DataColumn(
                        label: Text('Purchase \nCost',
                            style: TextStyle(fontSize: 14)),
                        numeric: false),
                    DataColumn(
                        label:
                            Text('Value\n@LTP', style: TextStyle(fontSize: 14)),
                        numeric: false),
                    DataColumn(
                        label: Text('Profit\n/Loss',
                            style: TextStyle(fontSize: 14)),
                        numeric: false),
                  ],
                  rows: (Provider.of<ShareDataProvider>(context, listen: false)
                          .shareData)
                      .map(
                        (shareData) => DataRow(
                          cells: [
                            DataCell(
                              Text(shareData.scrip,
                                  style: TextStyle(fontSize: 14)),
                            ),
                            DataCell(
                              FutureBuilder<String>(
                                future: Provider.of<ShareDataProvider>(context)
                                    .getPrice(
                                        shareData.companyName), // async work
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    default:
                                      if (snapshot.hasError)
                                        return Text('Error');
                                      else
                                        return Text('${snapshot.data}');
                                  }
                                },
                              ),
                            ),
                            DataCell(
                              Text(
                                shareData.quantity.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            DataCell(
                              Text(
                                shareData.price.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            DataCell(
                              FutureBuilder<String>(
                                future: getPriceData(
                                    shareData.companyName), // async work
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    default:
                                      if (snapshot.hasError)
                                        return Text('Error');
                                      else
                                        return Text(
                                          (double.parse(snapshot.data) *
                                                  shareData.quantity)
                                              .toString(),
                                        );
                                  }
                                },
                              ),
                            ),
                            DataCell(
                              FutureBuilder<String>(
                                future: getPriceData(
                                    shareData.companyName), // async work
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    default:
                                      if (snapshot.hasError)
                                        return Text('Error');
                                      else
                                        return Text(
                                            (double.parse(snapshot.data) *
                                                        shareData.quantity -
                                                    (shareData.quantity *
                                                        shareData.price))
                                                .toString());
                                  }
                                },
                              ),
                            ),
                          ],
                          onSelectChanged: (newValue) async {
                            bool result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShareDetails(
                                  shareData: shareData,
                                  ltp: getPriceData(shareData.companyName),
                                ),
                              ),
                            );
                            if (result == true) {
                              // this.shareDataList =
                              //     Provider.of<ShareDataProvider>(
                              //   context,
                              // ).shareData;
                              Provider.of<ShareDataProvider>(context)
                                  .getShareData();
                            }
                          },
                        ),
                      )
                      .toList()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDetails(),
            ),
          );
          if (result == true) {
            // this.shareDataList =
            //     Provider.of<ShareDataProvider>(context).shareData;
            Provider.of<ShareDataProvider>(context).getShareData();
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
