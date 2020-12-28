class GetAddressResponse {
  int status;
  String message;
  Data data;

  GetAddressResponse({this.status, this.message, this.data});

  GetAddressResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Address address;

  Data({this.address});

  Data.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Address {
  int count;
  List<Rows> rows;

  Address({this.count, this.rows});

  Address.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = new List<Rows>();
      json['rows'].forEach((v) {
        rows.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  int id;
  int userId;
  String fullAddress;
  Null city;
  String area;
  int pincode;
  String landmark;
  String latitude;
  String longitude;
  String placeType;
  String placeName;
  int isDeliveryAddress;
  String createdAt;
  String updatedAt;

  Rows(
      {this.id,
      this.userId,
      this.fullAddress,
      this.city,
      this.area,
      this.pincode,
      this.landmark,
      this.latitude,
      this.longitude,
      this.placeType,
      this.placeName,
      this.isDeliveryAddress,
      this.createdAt,
      this.updatedAt});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullAddress = json['full_address'];
    city = json['city'];
    area = json['area'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    placeType = json['place_type'];
    placeName = json['place_name'];
    isDeliveryAddress = json['is_delivery_address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['full_address'] = this.fullAddress;
    data['city'] = this.city;
    data['area'] = this.area;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['place_type'] = this.placeType;
    data['place_name'] = this.placeName;
    data['is_delivery_address'] = this.isDeliveryAddress;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
