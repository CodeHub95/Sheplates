// class NewReactiveRequest {
//   List<int> orderId;
//   String resumeSubscriptionDate;
//
//   NewReactiveRequest({this.orderId, this.resumeSubscriptionDate});
//
//   NewReactiveRequest.fromJson(Map<String, dynamic> json) {
//     orderId = json['orderId'].cast<int>();
//     resumeSubscriptionDate = json['resume_subscription_date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['orderId'] = this.orderId;
//     data['resume_subscription_date'] = this.resumeSubscriptionDate;
//     return data;
//   }
// }
class NewReactiveRequest {
  int orderId;
  String resumeSubscriptionDate;
  String sheplatesOrderId;
  int kitchenId;
  String preferredDeliveryTime;

  NewReactiveRequest(
      {this.orderId,
        this.resumeSubscriptionDate,
        this.sheplatesOrderId,
        this.kitchenId,
        this.preferredDeliveryTime});

  NewReactiveRequest.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    resumeSubscriptionDate = json['resume_subscription_date'];
    sheplatesOrderId = json['sheplates_order_id'];
    kitchenId = json['kitchen_id'];
    preferredDeliveryTime = json['preferred_delivery_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['resume_subscription_date'] = this.resumeSubscriptionDate;
    data['sheplates_order_id'] = this.sheplatesOrderId;
    data['kitchen_id'] = this.kitchenId;
    data['preferred_delivery_time'] = this.preferredDeliveryTime;
    return data;
  }
}
