class AddUserRequest {
  String type;
  String category;

  AddUserRequest({this.type, this.category });

  AddUserRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['category'] = this.category;
    return data;
  }
}