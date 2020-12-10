class StockCheckRequest {
  String duration;
  String endDate;
  String mealPlanId;
  String quantity;
  String startDate;
  String preferred_delivery_time;
  String holidays;

  StockCheckRequest(
      {this.duration,
      this.endDate,
      this.mealPlanId,
      this.quantity,
      this.startDate,
      this.holidays,
      this.preferred_delivery_time});

  factory StockCheckRequest.fromJson(Map<String, dynamic> json) {
    return StockCheckRequest(
        duration: json['duration'],
        endDate: json['endDate'],
        preferred_delivery_time: json['preferred_delivery_time '],
        mealPlanId: json['meal_plan_id'],
        quantity: json['quantity'],
        startDate: json['startDate'],
        holidays: json['holidays']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['endDate'] = this.endDate;
    data['meal_plan_id'] = this.mealPlanId;
    data['preferred_delivery_time'] = this.preferred_delivery_time;
    data['quantity'] = this.quantity;
    data['startDate'] = this.startDate;
    if (this.holidays != null) {
      data['holidays'] = this.holidays;
    }
    return data;
  }
}
