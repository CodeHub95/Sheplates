class LoginResponse {
  int status;
  String message;
  String token;
  Data data;

  LoginResponse({this.status, this.message, this.token, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Profile profile;

  Data({this.profile});

  Data.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }
}

class Profile {
  int id;
  int roleId;
  String firstName;
  String lastName;
  String email;
  String profileImage;
  String phone;
  List<UserAddresses> userAddresses;

  Profile(
      {this.id,
      this.roleId,
      this.firstName,
      this.lastName,
      this.email,
      this.profileImage,
      this.phone,
      this.userAddresses});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profileImage = json['profile_image'];
    phone = json['phone'];
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
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['phone'] = this.phone;
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
  String addressLine1;
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
      this.addressLine1,
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
    addressLine1 = json['address_line1'];
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
    data['address_line1'] = this.addressLine1;
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
