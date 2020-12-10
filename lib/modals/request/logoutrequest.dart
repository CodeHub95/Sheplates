class LogoutRequest {
  String deviceId;
  String userId;

  LogoutRequest({this.deviceId, this.userId});

  LogoutRequest.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_id'] = this.deviceId;
    data['user_id'] = this.userId;
    return data;
  }
}