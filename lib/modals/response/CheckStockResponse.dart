class Stock {
  int _status;
  String _message;
  Data _data;

  Stock({int status, String message, Data data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  int get status => _status;
  set status(int status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  Data get data => _data;
  set data(Data data) => _data = data;

  Stock.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class Data {
  int _effectivePlanDuration;
  int _mealPlanPrice;
  int _delieveryCharges;
  int _packagingCharges;
  int _gst;
  int _total;

  Data(
      {int effectivePlanDuration,
        int mealPlanPrice,
        int delieveryCharges,
        int packagingCharges,
        int gst,
        int total}) {
    this._effectivePlanDuration = effectivePlanDuration;
    this._mealPlanPrice = mealPlanPrice;
    this._delieveryCharges = delieveryCharges;
    this._packagingCharges = packagingCharges;
    this._gst = gst;
    this._total = total;
  }

  int get effectivePlanDuration => _effectivePlanDuration;
  set effectivePlanDuration(int effectivePlanDuration) =>
      _effectivePlanDuration = effectivePlanDuration;
  int get mealPlanPrice => _mealPlanPrice;
  set mealPlanPrice(int mealPlanPrice) => _mealPlanPrice = mealPlanPrice;
  int get delieveryCharges => _delieveryCharges;
  set delieveryCharges(int delieveryCharges) =>
      _delieveryCharges = delieveryCharges;
  int get packagingCharges => _packagingCharges;
  set packagingCharges(int packagingCharges) =>
      _packagingCharges = packagingCharges;
  int get gst => _gst;
  set gst(int gst) => _gst = gst;
  int get total => _total;
  set total(int total) => _total = total;

  Data.fromJson(Map<String, dynamic> json) {
    _effectivePlanDuration = json['effectivePlanDuration'];
    _mealPlanPrice = json['mealPlanPrice'];
    _delieveryCharges = json['delieveryCharges'];
    _packagingCharges = json['packagingCharges'];
    _gst = json['gst'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['effectivePlanDuration'] = this._effectivePlanDuration;
    data['mealPlanPrice'] = this._mealPlanPrice;
    data['delieveryCharges'] = this._delieveryCharges;
    data['packagingCharges'] = this._packagingCharges;
    data['gst'] = this._gst;
    data['total'] = this._total;
    return data;
  }
}
