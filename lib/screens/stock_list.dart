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

class StockList extends StatefulWidget {
  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this.getShareDataList();
  }

  void getShareDataList() {
    print(Provider.of<ShareDataProvider>(context).shareData);
    shareDataList = Provider.of<ShareDataProvider>(context).shareData;
  }

  @override
  Widget build(BuildContext context) {
    if (shareDataList == null) {
      setState(() {
        shareDataList = [];
        getShareDataList();
      });
    }
    return Scaffold(
      appBar: AppBar(title: Text('DashBoard')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                    columnSpacing: 5.0,
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
                    ],
                    rows: shareDataList
                        .map(
                          (shareData) => DataRow(
                            cells: [
                              DataCell(
                                Text(shareData.scrip,
                                    style: TextStyle(fontSize: 14)),
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
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        else
                                          return Text('${snapshot.data}');
                                    }
                                  },
                                ),
                              ),
                            ],
                            onSelectChanged: (newValue) async {
                              bool result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShareDetails(shareData: shareData),
                                ),
                              );
                              if (result == true) {
                                getShareDataList();
                              }
                            },
                          ),
                        )
                        .toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
