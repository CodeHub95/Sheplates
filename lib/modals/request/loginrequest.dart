class LoginRequest {
  String phone;
  String password;
  String deviceId;
  String deviceToken;
  String deviceType;

  LoginRequest(
      {this.phone,
        this.password,
        this.deviceId,
        this.deviceToken,
        this.deviceType});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    deviceId = json['device_id'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['device_id'] = this.deviceId;
    data['device_token'] = this.deviceToken;
    data['device_type'] = this.deviceType;
    return data;
  }
}
