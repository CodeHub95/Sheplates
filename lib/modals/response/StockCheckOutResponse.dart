class StockCheckOutResponse {
  StockData data;
  String message;
  num status;

  StockCheckOutResponse({this.data, this.message, this.status});

  factory StockCheckOutResponse.fromJson(Map<String, dynamic> json) {
    return StockCheckOutResponse(
      data: json['data'] != null ? StockData.fromJson(json['data']) : StockData(),
      message: json['message'] != null ? json['message'] : "",
      status: json['status'] != null ? json['status'] : 500,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class StockData {
  num delieveryCharges;
  num effectivePlanDuration;
  num gst;
  num mealPlanPrice;
  num packagingCharges;
  num total;

  StockData(
      {this.delieveryCharges,
      this.effectivePlanDuration,
      this.gst,
      this.mealPlanPrice,
      this.packagingCharges,
      this.total});

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      delieveryCharges:
          json['delieveryCharges'] != null ? json['delieveryCharges'] : 0,
      effectivePlanDuration: json['effectivePlanDuration'] != null
          ? json['effectivePlanDuration']
          : 0,
      gst: json['gst'] != null ? json['gst'] : 0,
      mealPlanPrice: json['mealPlanPrice'] != null ? json['mealPlanPrice'] : 0,
      packagingCharges:
          json['packagingCharges'] != null ? json['packagingCharges'] : 0,
      total: json['total'] != null ? json['total'] : 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delieveryCharges'] = this.delieveryCharges;
    data['effectivePlanDuration'] = this.effectivePlanDuration;
    data['gst'] = this.gst;
    data['mealPlanPrice'] = this.mealPlanPrice;
    data['packagingCharges'] = this.packagingCharges;
    data['total'] = this.total;
    return data;
  }
}
