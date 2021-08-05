class ConfirmOrderRequestModel {
  String startDate;
  String endDate;
  String quantity;
  String duration;
  String mealPlanId;
  String holidays;
  String preferredDeliveryTime;

  ConfirmOrderRequestModel(
      {this.duration,
        this.endDate,
        this.mealPlanId,
        this.quantity,
        this.startDate,
        this.holidays,
        this.preferredDeliveryTime});

  factory ConfirmOrderRequestModel.fromJson(Map<String, dynamic> json) {
    return ConfirmOrderRequestModel(
        duration: json['duration'],
        endDate: json['endDate'],
        preferredDeliveryTime: json['preferred_delivery_time '],
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
    data['preferred_delivery_time'] = this.preferredDeliveryTime;
    data['quantity'] = this.quantity;
    data['startDate'] = this.startDate;
    if (this.holidays != null) {
      data['holidays'] = this.holidays;
    }
    return data;
  }
}
