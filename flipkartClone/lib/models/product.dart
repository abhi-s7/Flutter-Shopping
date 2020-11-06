class Product {
  String _name;
  String _status;
  String _url;
  double _price;
  String _imagePath;

  String get name => _name;

  set name(String value) => _name = value;

  String get status => _status;

  set status(String value) => _status = value;

  String get url => _url;

  set url(String value) => _url = value;

  double get price => _price;

  set price(double value) => _price = value;

  String get imagePath => _imagePath;

  set imagePath(String value) => _imagePath = value;

  @override
  String toString() {
    return 'Product{_name: $_name, _url: $_url, _price: $_price, _status: $_status _imagePath: $_imagePath}';
  }
}
