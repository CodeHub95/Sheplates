class EditProfileResponse {
  int status;
  String message;
  Data data;

  EditProfileResponse({this.status, this.message, this.data});

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
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
  UserData userData;

  Data({this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['userData'] = this.userData.toJson();
    }
    return data;
  }
}

class UserData {
  int id;
  int roleId;
  String first_name;
  String last_name;
  String gender;
  String dob;
  String email;
  String phone;
  String profile_image;
  String status;
  String lastSeen;
  List<UserAddresses> userAddresses;

  UserData(
      {this.id,
        this.roleId,
        this.first_name,
        this.last_name,
        this.gender,
        this.dob,
        this.email,
        this.phone,
        this.profile_image,
        this.status,
        this.lastSeen,
        this.userAddresses});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    gender = json['gender'];
    dob = json['dob'];
    email = json['email'];
    phone = json['phone'];
    profile_image = json['profile_image'];
    status = json['status'];
    lastSeen = json['last_seen'];
    if (json['user_addresses'] != null) {
      userAddresses = new List<UserAddresses>();
      json['user_addresses'].forEach((v) {
        userAddresses.add(new UserAddresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['profile_image'] = this.profile_image;
    data['status'] = this.status;
    data['last_seen'] = this.lastSeen;
    if (this.userAddresses != null) {
      data['user_addresses'] =
          this.userAddresses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserAddresses {
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

  UserAddresses(
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
        this.isDeliveryAddress});

  UserAddresses.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}