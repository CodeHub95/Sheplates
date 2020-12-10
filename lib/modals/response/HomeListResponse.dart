import 'MealCategory.dart';

class HomeListResponse {
  int status;
  String message;
  Data data;

  HomeListResponse({this.status, this.message, this.data});

  HomeListResponse.fromJson(Map<String, dynamic> json) {
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
  SubscriptionPlanData subscriptionPlanData;
  bool suscriber;
  int deliveryAddressExist;

  Data({this.subscriptionPlanData, this.suscriber, this.deliveryAddressExist});

  Data.fromJson(Map<String, dynamic> json) {
    subscriptionPlanData = json['subscriptionPlanData'] != null
        ? new SubscriptionPlanData.fromJson(json['subscriptionPlanData'])
        : null;
    suscriber = json['suscriber'] != null ? json['suscriber'] : false;
    deliveryAddressExist =
        json['deliveryAddressExist'] != null ? json['deliveryAddressExist'] : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscriptionPlanData != null) {
      data['subscriptionPlanData'] = this.subscriptionPlanData.toJson();
    }
    data['suscriber'] = this.suscriber;
    data['deliveryAddressExist'] = this.deliveryAddressExist;
    return data;
  }
}

class SubscriptionPlanData {
  int count;
  List<Rows> rows;

  SubscriptionPlanData({this.count, this.rows});

  SubscriptionPlanData.fromJson(Map<String, dynamic> json) {
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
  String category;
  MealCategory mealCategory;
  String mealName;
  int price;
  Menu menu;

  Rows(
      {this.id,
      this.category,
      this.mealName,
      this.price,
      this.menu,
      this.mealCategory});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    mealName = json['meal_name'];
    price = json['price'];
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
    mealCategory = json['meal_category'] != null
        ? new MealCategory.fromJson(json['meal_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['meal_name'] = this.mealName;
    data['price'] = this.price;
    if (this.menu != null) {
      data['menu'] = this.menu.toJson();
    }
    if (this.mealCategory != null) {
      data['meal_category'] = this.mealCategory.toJson();
    }
    return data;
  }
}

class Menu {
  int id;
  String monday;
  String tuesday;
  String wednesday;
  String thrusday;
  String friday;
  String saturday;
  String sunday;

  Menu(
      {this.id,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thrusday,
      this.friday,
      this.saturday,
      this.sunday});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thrusday = json['thrusday'];
    friday = json['friday'];
    saturday = json['saturday'];
    sunday = json['sunday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thrusday'] = this.thrusday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    data['sunday'] = this.sunday;
    return data;
  }
}
