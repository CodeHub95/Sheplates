class AddUserRequest {
  String type;
  String category;
  String address;

  AddUserRequest({this.type, this.category, this.address});

  AddUserRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    category = json['category'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['category'] = this.category;
    data['address'] = this.address;
    return data;
  }
}