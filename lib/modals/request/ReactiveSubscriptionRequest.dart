class ReactiveSubscriptionRequest {
  int orderId;
  String resume_subscription_date;
  ReactiveSubscriptionRequest({this.orderId, this.resume_subscription_date });

  ReactiveSubscriptionRequest.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    resume_subscription_date = json['resume_subscription_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['resume_subscription_date'] = this.resume_subscription_date;
    return data;
  }
}