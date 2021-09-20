class MenuResponse {
  int status;
  String message;
  List<Obj> data;

  MenuResponse({this.status, this.message, this.data});

  MenuResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Obj>();
      json['data'].forEach((v) {
        data.add(new Obj.fromJson(v));
      });
    }else null;
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
  Menu menu;
  String kitchen;
  String kitchenAddress;
 bool isExpanded = false;
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
        this.menu,
        this.kitchen,
        this.kitchenAddress,
      this.isExpanded});

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
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
    kitchen = json['kitchen'];
    kitchenAddress = json['kitchen_address'];
    isExpanded = json['isExpanded'];
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
    if (this.menu != null) {
      data['menu'] = this.menu.toJson();
    }
    data['kitchen'] = this.kitchen;
    data['kitchen_address'] = this.kitchenAddress;
    if(this.isExpanded != null){
    data['isExpanded'] = this.isExpanded;}
    else data['isExpanded'] = false;
    return data;
  }
}

class Menu {
  int id;
  int catalogId;
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
  String createdAt;
  String updatedAt;

  Menu(
      {this.id,
        this.catalogId,
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
        this.createdAt,
        this.updatedAt});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catalogId = json['catalog_id'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catalog_id'] = this.catalogId;
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thrusday'] = this.thrusday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    data['sunday'] = this.sunday;
    data['monday2'] = this.monday2;
    data['tuesday2'] = this.tuesday2;
    data['wednesday2'] = this.wednesday2;
    data['thrusday2'] = this.thrusday2;
    data['friday2'] = this.friday2;
    data['saturday2'] = this.saturday2;
    data['sunday2'] = this.sunday2;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
