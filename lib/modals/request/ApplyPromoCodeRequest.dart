class ApplyPromoCodeRequest {
  String type;
  String code;

  ApplyPromoCodeRequest({this.type, this.code});

  ApplyPromoCodeRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['code'] = this.code;
    return data;
  }
}
