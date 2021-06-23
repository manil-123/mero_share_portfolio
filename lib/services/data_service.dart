import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mero_share_portfolio/models/models.dart';

const nepseApiURL = 'https://nepse-data-api.herokuapp.com/data/todaysprice';
// const nepseApiURL =
//     'https://newweb.nepalstock.com/api/nots/nepse-data/today-price?size=300';

class DataService {
  // A function that converts a response body into a List<NepseShareDataModel>.
  List<NepseShareDataModel> parseShareData(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<NepseShareDataModel>((json) => NepseShareDataModel.fromJson(json))
        .toList();
  }

  Future<List<NepseShareDataModel>> fetchShareData(http.Client client) async {
    final response = await client.get(Uri.parse(nepseApiURL));

    // Use the compute function to run parseShareData in a separate isolate.
    return parseShareData(response.body);
  }
}
