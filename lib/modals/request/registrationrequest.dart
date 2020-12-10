class RegisterRequest {
  String phone;
  String first_Name;
  String last_Name;
  String email;
  String password;
  String deviceId;
  String deviceToken;
  String deviceType;

  RegisterRequest(
      {this.phone,
        this.first_Name,
        this.last_Name,
        this.email,
        this.password,
        this.deviceId,
        this.deviceToken,
        this.deviceType});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    first_Name = json['first_name'];
    last_Name = json['last_name'];
    email= json['email'];
    password = json['password'];
    deviceId = json['device_id'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['first_name'] = this.first_Name;
    data['last_name'] = this.last_Name;
    data['email']= this.email;
    data['password'] = this.password;
    data['device_id'] = this.deviceId;
    data['device_token'] = this.deviceToken;
    data['device_type'] = this.deviceType;
    return data;
  }
}