class AppDownloadRequest {
  String deviceId;

  AppDownloadRequest({this.deviceId });

  AppDownloadRequest.fromJson(Map<String, dynamic> json) {
    deviceId= json['deviceId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceId'] = this.deviceId;

    return data;
  }
}