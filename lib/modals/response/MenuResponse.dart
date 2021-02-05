class MenuResponse {
  int status;
  String message;
  Data data;

  MenuResponse({this.status, this.message, this.data});

  MenuResponse.fromJson(Map<String, dynamic> json) {
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
  Obj obj;

  Data({this.obj});

  Data.fromJson(Map<String, dynamic> json) {
    obj = json['obj'] != null ? new Obj.fromJson(json['obj']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.obj != null) {
      data['obj'] = this.obj.toJson();
    }
    return data;
  }
}

class Obj {
  int subscriptionPlanId;
  String duration;
  String startDate;
  int amountPaid;
  int mealsServed;
  int mealsRemaining;
  String mealName;
  String mealCategory;
  String servingToday;
  String kitchen;
  String kitchenAddress;
  Menu menu;

  Obj(
      {this.subscriptionPlanId,
        this.duration,
        this.startDate,
        this.amountPaid,
        this.mealsServed,
        this.mealsRemaining,
        this.mealName,
        this.mealCategory,
        this.servingToday,
        this.kitchen,
        this.kitchenAddress,
        this.menu});

  Obj.fromJson(Map<String, dynamic> json) {
    subscriptionPlanId = json['subscription_plan_id'];
    duration = json['duration'];
    startDate = json['start_date'];
    amountPaid = json['amount_paid'];
    mealsServed = json['meals_served'];
    mealsRemaining = json['meals_remaining'];
    mealName = json['meal_name'];
    mealCategory = json['meal_category'];
    servingToday = json['serving_today'];
    kitchen = json['kitchen'];
    kitchenAddress = json['kitchen_address'];
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscription_plan_id'] = this.subscriptionPlanId;
    data['duration'] = this.duration;
    data['start_date'] = this.startDate;
    data['amount_paid'] = this.amountPaid;
    data['meals_served'] = this.mealsServed;
    data['meals_remaining'] = this.mealsRemaining;
    data['meal_name'] = this.mealName;
    data['meal_category'] = this.mealCategory;
    data['serving_today'] = this.servingToday;
    data['kitchen'] = this.kitchen;
    data['kitchen_address'] = this.kitchenAddress;
    if (this.menu != null) {
      data['menu'] = this.menu.toJson();
    }
    return data;
  }
}

class Menu {
  String monday;
  String tuesday;
  String wednesday;
  String thrusday;
  String friday;
  String saturday;
  String sunday;

  Menu(
      {this.monday,
        this.tuesday,
        this.wednesday,
        this.thrusday,
        this.friday,
        this.saturday,
      this.sunday});

  Menu.fromJson(Map<String, dynamic> json) {
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
