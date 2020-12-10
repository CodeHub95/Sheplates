class SubscriptionResponse {
  int status;
  String message;
  Data data;

  SubscriptionResponse({this.status, this.message, this.data});

  SubscriptionResponse.fromJson(Map<String, dynamic> json) {
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
  List<ActiveSubscription> activeSubscription;
  List<PastSubscription> pastSubscription;

  Data({this.activeSubscription, this.pastSubscription});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['activeSubscription'] != null) {
      activeSubscription = new List<ActiveSubscription>();
      json['activeSubscription'].forEach((v) {
        activeSubscription.add(new ActiveSubscription.fromJson(v));
      });
    }
    if (json['pastSubscription'] != null) {
      pastSubscription = new List<PastSubscription>();
      json['pastSubscription'].forEach((v) {
        pastSubscription.add(new PastSubscription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activeSubscription != null) {
      data['activeSubscription'] =
          this.activeSubscription.map((v) => v.toJson()).toList();
    }
    if (this.pastSubscription != null) {
      data['pastSubscription'] =
          this.pastSubscription.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActiveSubscription {
  int id;
  int userId;
  int mealPlanId;
  int kitchenId;
  String preferredDeliveryTime;
  int quantity;
  String duration;
  int basicSubscriptionPrice;
  int totalMealCount;
  int delieveryCharges;
  int packagingCharges;
  int mealsServed;
  int gstPercentage;
  int gstAmount;
  int totalAmount;
  String startDate;
  String endDate;
  String holidays;
  String status;
  String createdAt;
  String updatedAt;
  Kitchen kitchen;
  Catalog catalog;

  ActiveSubscription(
      {this.id,
        this.userId,
        this.mealPlanId,
        this.kitchenId,
        this.preferredDeliveryTime,
        this.quantity,
        this.duration,
        this.basicSubscriptionPrice,
        this.totalMealCount,
        this.delieveryCharges,
        this.packagingCharges,
        this.mealsServed,
        this.gstPercentage,
        this.gstAmount,
        this.totalAmount,
        this.startDate,
        this.endDate,
        this.holidays,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.kitchen,
        this.catalog});

  ActiveSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mealPlanId = json['meal_plan_id'];
    kitchenId = json['kitchen_id'];
    preferredDeliveryTime = json['preferred_delivery_time'];
    quantity = json['quantity'];
    duration = json['duration'];
    basicSubscriptionPrice = json['basic_subscription_price'];
    totalMealCount = json['total_meal_count'];
    delieveryCharges = json['delievery_charges'];
    packagingCharges = json['packaging_charges'];
    mealsServed = json['meals_served'];
    gstPercentage = json['gst_percentage'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    holidays = json['holidays'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    kitchen =
    json['kitchen'] != null ? new Kitchen.fromJson(json['kitchen']) : null;
    catalog =
    json['catalog'] != null ? new Catalog.fromJson(json['catalog']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['meal_plan_id'] = this.mealPlanId;
    data['kitchen_id'] = this.kitchenId;
    data['preferred_delivery_time'] = this.preferredDeliveryTime;
    data['quantity'] = this.quantity;
    data['duration'] = this.duration;
    data['basic_subscription_price'] = this.basicSubscriptionPrice;
    data['total_meal_count'] = this.totalMealCount;
    data['delievery_charges'] = this.delieveryCharges;
    data['packaging_charges'] = this.packagingCharges;
    data['meals_served'] = this.mealsServed;
    data['gst_percentage'] = this.gstPercentage;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['holidays'] = this.holidays;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.kitchen != null) {
      data['kitchen'] = this.kitchen.toJson();
    }
    if (this.catalog != null) {
      data['catalog'] = this.catalog.toJson();
    }
    return data;
  }
}
class PastSubscription {
  int id;
  int userId;
  int mealPlanId;
  int kitchenId;
  String preferredDeliveryTime;
  int quantity;
  String duration;
  int basicSubscriptionPrice;
  int totalMealCount;
  int delieveryCharges;
  int packagingCharges;
  int mealsServed;
  int gstPercentage;
  int gstAmount;
  int totalAmount;
  String startDate;
  String endDate;
  String holidays;
  String status;
  String createdAt;
  String updatedAt;
  Kitchen kitchen;
  Catalog catalog;

  PastSubscription(
      {this.id,
        this.userId,
        this.mealPlanId,
        this.kitchenId,
        this.preferredDeliveryTime,
        this.quantity,
        this.duration,
        this.basicSubscriptionPrice,
        this.totalMealCount,
        this.delieveryCharges,
        this.packagingCharges,
        this.mealsServed,
        this.gstPercentage,
        this.gstAmount,
        this.totalAmount,
        this.startDate,
        this.endDate,
        this.holidays,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.kitchen,
        this.catalog});

  PastSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mealPlanId = json['meal_plan_id'];
    kitchenId = json['kitchen_id'];
    preferredDeliveryTime = json['preferred_delivery_time'];
    quantity = json['quantity'];
    duration = json['duration'];
    basicSubscriptionPrice = json['basic_subscription_price'];
    totalMealCount = json['total_meal_count'];
    delieveryCharges = json['delievery_charges'];
    packagingCharges = json['packaging_charges'];
    mealsServed = json['meals_served'];
    gstPercentage = json['gst_percentage'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    holidays = json['holidays'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    kitchen =
    json['kitchen'] != null ? new Kitchen.fromJson(json['kitchen']) : null;
    catalog =
    json['catalog'] != null ? new Catalog.fromJson(json['catalog']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['meal_plan_id'] = this.mealPlanId;
    data['kitchen_id'] = this.kitchenId;
    data['preferred_delivery_time'] = this.preferredDeliveryTime;
    data['quantity'] = this.quantity;
    data['duration'] = this.duration;
    data['basic_subscription_price'] = this.basicSubscriptionPrice;
    data['total_meal_count'] = this.totalMealCount;
    data['delievery_charges'] = this.delieveryCharges;
    data['packaging_charges'] = this.packagingCharges;
    data['meals_served'] = this.mealsServed;
    data['gst_percentage'] = this.gstPercentage;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['holidays'] = this.holidays;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.kitchen != null) {
      data['kitchen'] = this.kitchen.toJson();
    }
    if (this.catalog != null) {
      data['catalog'] = this.catalog.toJson();
    }
    return data;
  }
}
class Kitchen {
  int id;
  String kitchenName;
  String address;

  Kitchen({this.id, this.kitchenName, this.address});

  Kitchen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kitchenName = json['kitchen_name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kitchen_name'] = this.kitchenName;
    data['address'] = this.address;
    return data;
  }
}

class Catalog {
  int id;
  String mealName;

  Catalog({this.id, this.mealName});

  Catalog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealName = json['meal_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meal_name'] = this.mealName;
    return data;
  }
}