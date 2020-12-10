class SupportRequest {
  String type;
  String details;

  SupportRequest({this.type, this.details });

  SupportRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    details = json['details'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['details'] = this.details;

    return data;
  }
}