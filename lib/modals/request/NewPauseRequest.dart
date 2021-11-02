class NewPauseRequest {
  int orderId;
  String pauseSubscriptionDate;
  String sheplatesOrderId;
  int kitchenId;
  String preferredDeliveryTime;

  NewPauseRequest(
      {this.orderId,
        this.pauseSubscriptionDate,
        this.sheplatesOrderId,
        this.kitchenId,
        this.preferredDeliveryTime});

  NewPauseRequest.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    pauseSubscriptionDate = json['pause_subscription_date'];
    sheplatesOrderId = json['sheplates_order_id'];
    kitchenId = json['kitchen_id'];
    preferredDeliveryTime = json['preferred_delivery_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['pause_subscription_date'] = this.pauseSubscriptionDate;
    data['sheplates_order_id'] = this.sheplatesOrderId;
    data['kitchen_id'] = this.kitchenId;
    data['preferred_delivery_time'] = this.preferredDeliveryTime;
    return data;
  }
}
