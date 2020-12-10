class UserFeedbackRequest {
  int orderId;
  int taste;
  int packaging;
  int valueOfMoney;
  int deliveryExperience;
  int quantity;

  UserFeedbackRequest({
    this.orderId,
    this.taste,
    this.packaging,
    this.valueOfMoney,
    this.deliveryExperience,
    this.quantity,
  });

  factory UserFeedbackRequest.fromJson(Map<String, dynamic> json) {
    return UserFeedbackRequest(
      orderId: json['orderId'],
      taste: json['taste'],
      packaging: json['packaging '],
      valueOfMoney: json['valueOfMoney'],
      deliveryExperience: json['deliveryExperience'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['taste'] = this.taste;
    data['packaging'] = this.packaging;
    data['valueOfMoney'] = this.valueOfMoney;
    data['quantity'] = this.quantity;
    data['deliveryExperience'] = this.deliveryExperience;

    return data;
  }
}
