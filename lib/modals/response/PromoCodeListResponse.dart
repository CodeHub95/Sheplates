class PromoCodeListResponse {
  int status;
  String message;
  List<Promocode> data;

  PromoCodeListResponse({this.status, this.message, this.data});

  PromoCodeListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Promocode>();
      json['data'].forEach((v) {
        data.add(new Promocode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Promocode {
  String name;
  String description;
  String type;
  String code;
  int offerUpTo;

  Promocode({this.name, this.description, this.type, this.code, this.offerUpTo});

  Promocode.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    type = json['type'];
    code = json['code'];
    offerUpTo = json['offerUpTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['code'] = this.code;
    data['offerUpTo'] = this.offerUpTo;
    return data;
  }
}
