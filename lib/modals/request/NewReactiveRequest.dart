class NewReactiveRequest {
  List<int> orderId;
  String resumeSubscriptionDate;

  NewReactiveRequest({this.orderId, this.resumeSubscriptionDate});

  NewReactiveRequest.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'].cast<int>();
    resumeSubscriptionDate = json['resume_subscription_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['resume_subscription_date'] = this.resumeSubscriptionDate;
    return data;
  }
}
