/*
"companyName": "10% Himalayan Bank Debenture 2083",
"noOfTransactions": 1,
"maxPrice": 1050,
"minPrice": 1050,
"closingPrice": 1050,
"tradedShares": 25,
"amount": 26250,
"previousClosing": 1055,
"difference": -5
 */

class NepseShareDataModel {
  String companyName;
  // String scrip;
  var closingPrice;

  NepseShareDataModel({
    this.companyName,
    // this.scrip,
    this.closingPrice,
  });

  factory NepseShareDataModel.fromJson(Map<String, dynamic> json) =>
      NepseShareDataModel(
        companyName: json['companyName'],
        // scrip: json['symbol'],
        closingPrice: json['closingPrice'],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        // "symbol": scrip,
        "closingPrice": closingPrice,
      };
}
