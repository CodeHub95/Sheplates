class NewPauseRequest {
  List<int> orderId;
  String pauseSubscriptionDate;

  NewPauseRequest({this.orderId, this.pauseSubscriptionDate});

  NewPauseRequest.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'].cast<int>();
    pauseSubscriptionDate = json['pause_subscription_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['pause_subscription_date'] = this.pauseSubscriptionDate;
    return data;
  }
}
