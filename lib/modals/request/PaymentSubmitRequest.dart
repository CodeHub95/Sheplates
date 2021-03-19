class PaymentSubmitRequest {
  String orderId;
  String transactionId;
  num amount;
  String paymentMode;
  String status;
  String type;
  String razorpay_payment_id;
 String razorpay_order_id;
 String razorpay_signature;
  PaymentSubmitRequest({this.orderId, this.transactionId, this.amount, this.paymentMode, this.status,
    this.razorpay_order_id, this.razorpay_signature, this.razorpay_payment_id, this.type,});


  factory PaymentSubmitRequest.fromJson(Map<String, dynamic> json) {
    return PaymentSubmitRequest(
      orderId: json['orderId'],
      transactionId: json['transactionId'],
      amount: json['amount'],
      paymentMode: json['paymentMode'],
      status: json['status'],
      type: json['type'],
        razorpay_payment_id: json['razorpay_payment_id'],
      razorpay_signature: json['razorpay_signature'],
      razorpay_order_id: json['razorpay_payment_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['transactionId'] = this.transactionId;
    data['amount'] = this.amount;
    data['paymentMode'] = this.paymentMode;
    data['status'] = this.status;
    data['type'] = this.type;
    data['razorpay_payment_id'] = this.razorpay_payment_id;
    data['razorpay_signature'] = this.razorpay_signature;
    data['razorpay_order_id'] = this.razorpay_order_id;
    return data;
  }
}