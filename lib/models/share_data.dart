class ShareData {
  int _id;
  String _scrip;
  String _companyName;
  int _quantity;
  int _price;

  ShareData(
    this._scrip,
    this._companyName,
    this._quantity,
    this._price,
  );

  int get price => _price;

  int get quantity => _quantity;

  String get scrip => _scrip;

  String get companyName => _companyName;

  int get id => _id;

  // Convert a ShareData object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['scrip'] = _scrip;
    map['companyName'] = _companyName;
    map['quantity'] = _quantity;
    map['price'] = _price;
    return map;
  }

  // Extract a ShareData object from a Map object
  ShareData.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._scrip = map['scrip'];
    this._companyName = map['companyName'];
    this._quantity = map['quantity'];
    this._price = map['price'];
  }
}
