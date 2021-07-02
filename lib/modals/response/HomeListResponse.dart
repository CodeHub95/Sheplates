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
    subscriptionPlanData =
        json['subscriptionPlanData'] != null ? new SubscriptionPlanData.fromJson(json['subscriptionPlanData']) : null;
    suscriber = json['suscriber'] != null ? json['suscriber'] : false;
    deliveryAddressExist = json['deliveryAddressExist'] != null ? json['deliveryAddressExist'] : 0;
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

  Rows({this.id, this.category, this.mealName, this.price, this.menu, this.mealCategory});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    mealName = json['meal_name'];
    price = json['price'];
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
    mealCategory = json['meal_category'] != null ? new MealCategory.fromJson(json['meal_category']) : null;
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
  String monday2;
  String tuesday2;
  String wednesday2;
  String thrusday2;
  String friday2;
  String saturday2;
  String sunday2;

  Menu({
    this.id,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thrusday,
    this.friday,
    this.saturday,
    this.sunday,
    this.monday2,
    this.tuesday2,
    this.wednesday2,
    this.thrusday2,
    this.friday2,
    this.saturday2,
    this.sunday2,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thrusday = json['thrusday'];
    friday = json['friday'];
    saturday = json['saturday'];
    sunday = json['sunday'];
    monday2 = json['monday2'];
    tuesday2 = json['tuesday2'];
    wednesday2 = json['wednesday2'];
    thrusday2 = json['thrusday2'];
    friday2 = json['friday2'];
    saturday2 = json['saturday2'];
    sunday2 = json['sunday2'];
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
    data['monday2'] = this.monday2;
    data['tuesday'] = this.tuesday2;
    data['wednesday2'] = this.wednesday2;
    data['thrusday2'] = this.thrusday2;
    data['friday2'] = this.friday2;
    data['saturday'] = this.saturday2;
    data['sunday2'] = this.sunday2;

    return data;
  }
}
