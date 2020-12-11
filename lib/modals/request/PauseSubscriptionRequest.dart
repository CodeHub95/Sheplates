class PauseSubscriptionRequest {
  String token;
  String pause_subscription_date;
  int orderId;
  PauseSubscriptionRequest({this.token, this.orderId, this.pause_subscription_date });

  PauseSubscriptionRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    pause_subscription_date = json['pause_subscription_date'];
    orderId =json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['pause_subscription_date'] = this.pause_subscription_date;
    data['orderId'] = this.orderId;
    return data;
  }
}