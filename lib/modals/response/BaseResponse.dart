class BaseResponse {
  String message;
  int status;
  String statusCode;

  BaseResponse({this.message, this.status, this.statusCode});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      message: json['message'],
      status: json['status'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    return data;
  }
}
