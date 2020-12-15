class PauseScreenDataResponse {
  int status;
  String message;
  Data data;

  PauseScreenDataResponse({this.status, this.message, this.data});

  PauseScreenDataResponse.fromJson(Map<String, dynamic> json) {
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
  Order order;

  Data({this.address, this.order});

  Data.fromJson(Map<String, dynamic> json) {
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    return data;
  }
}

class Address {
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

  Address(
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

  Address.fromJson(Map<String, dynamic> json) {
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

class Order {
  int id;
  int totalMealCount;
  int mealsServed;
  String status;
  String start_date;
  String end_date;
  Order({this.id, this.totalMealCount, this.mealsServed, this.status, this.end_date, this.start_date});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    end_date = json['end_date'];
    start_date = json['start_date'];
    totalMealCount = json['total_meal_count'];
    mealsServed = json['meals_served'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_meal_count'] = this.totalMealCount;
    data['end_date'] = this.end_date;
    data['start_date'] = this.start_date;
    data['meals_served'] = this.mealsServed;
    data['status'] = this.status;
    return data;
  }
}