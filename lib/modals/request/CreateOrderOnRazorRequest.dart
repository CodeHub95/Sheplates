class CreateOrderOnRazorRequest {
  num amount;
  String currency;
  String receipt;
  String payment_capture;

  CreateOrderOnRazorRequest({this.amount, this.currency, this.receipt,
    this.payment_capture,

  });

  factory CreateOrderOnRazorRequest.fromJson(Map<String, dynamic> json) {
    return CreateOrderOnRazorRequest(
      amount: json['amount'],
      currency: json['currency'],
      receipt: json['receipt'],
      payment_capture: json['payment_capture'],


    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['receipt'] = this.receipt;
    data['payment_capture'] = this.payment_capture;

    return data;
  }
}