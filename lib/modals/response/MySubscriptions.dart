// To parse this JSON data, do
//
//     final mySubscriptionResponse = mySubscriptionResponseFromJson(jsonString);

import 'dart:convert';

MySubscriptionResponse mySubscriptionResponseFromJson(String str) => MySubscriptionResponse.fromJson(json.decode(str));

String mySubscriptionResponseToJson(MySubscriptionResponse data) => json.encode(data.toJson());

class MySubscriptionResponse {
  MySubscriptionResponse({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory MySubscriptionResponse.fromJson(Map<String, dynamic> json) => MySubscriptionResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.activeSubscription,
    this.pastSubscription,
  });

  List<ActiveSubscription> activeSubscription;
  List<PastSubscription> pastSubscription;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        activeSubscription:
            List<ActiveSubscription>.from(json["activeSubscription"].map((x) => ActiveSubscription.fromJson(x))),
        pastSubscription:
            List<PastSubscription>.from(json["pastSubscription"].map((x) => PastSubscription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "activeSubscription": List<dynamic>.from(activeSubscription.map((x) => x.toJson())),
        "pastSubscription": List<dynamic>.from(pastSubscription.map((x) => x.toJson())),
      };
}

class ActiveSubscription {
  ActiveSubscription({
    this.sheplatesOrderId,
    this.orders,
  });

  String sheplatesOrderId;
  List<ActiveSubscriptionOrder> orders;

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) => ActiveSubscription(
        sheplatesOrderId: json["sheplates_order_id"],
        orders: List<ActiveSubscriptionOrder>.from(json["orders"].map((x) => ActiveSubscriptionOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sheplates_order_id": sheplatesOrderId,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class ActiveSubscriptionOrder {
  ActiveSubscriptionOrder({
    this.id,
    this.userId,
    this.mealPlanId,
    this.kitchenId,
    this.preferredDeliveryTime,
    this.quantity,
    this.duration,
    this.basicSubscriptionPrice,
    this.days,
    this.totalMealCount,
    this.delieveryCharges,
    this.packagingCharges,
    this.distance,
    this.mealsServed,
    this.gstPercentage,
    this.gstAmount,
    this.totalAmount,
    this.startDate,
    this.endDate,
    this.pauseSubscriptionDate,
    this.resumeSubscriptionDate,
    this.holidays,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.kitchen,
    this.catalog,
    this.transaction,
  });

  int id;
  int userId;
  int mealPlanId;
  int kitchenId;
  String preferredDeliveryTime;
  int quantity;
  String duration;
  int basicSubscriptionPrice;
  int days;
  int totalMealCount;
  int delieveryCharges;
  int packagingCharges;
  double distance;
  int mealsServed;
  int gstPercentage;
  int gstAmount;
  int totalAmount;
  DateTime startDate;
  DateTime endDate;
  DateTime pauseSubscriptionDate;
  DateTime resumeSubscriptionDate;
  String holidays;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Kitchen kitchen;
  Catalog catalog;
  Transaction transaction;

  factory ActiveSubscriptionOrder.fromJson(Map<String, dynamic> json) => ActiveSubscriptionOrder(
        id: json["id"],
        userId: json["user_id"],
        mealPlanId: json["meal_plan_id"],
        kitchenId: json["kitchen_id"],
        preferredDeliveryTime: json["preferred_delivery_time"],
        quantity: json["quantity"],
        duration: json["duration"],
        basicSubscriptionPrice: json["basic_subscription_price"],
        days: json["days"],
        totalMealCount: json["total_meal_count"],
        delieveryCharges: json["delievery_charges"],
        packagingCharges: json["packaging_charges"],
        distance: json["distance"].toDouble(),
        mealsServed: json["meals_served"],
        gstPercentage: json["gst_percentage"],
        gstAmount: json["gst_amount"],
        totalAmount: json["total_amount"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        pauseSubscriptionDate: DateTime.parse(json["pause_subscription_date"]),
        resumeSubscriptionDate: DateTime.parse(json["resume_subscription_date"]),
        holidays: json["holidays"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        kitchen: Kitchen.fromJson(json["kitchen"]),
        catalog: Catalog.fromJson(json["catalog"]),
        transaction: Transaction.fromJson(json["transaction"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "meal_plan_id": mealPlanId,
        "kitchen_id": kitchenId,
        "preferred_delivery_time": preferredDeliveryTime,
        "quantity": quantity,
        "duration": duration,
        "basic_subscription_price": basicSubscriptionPrice,
        "days": days,
        "total_meal_count": totalMealCount,
        "delievery_charges": delieveryCharges,
        "packaging_charges": packagingCharges,
        "distance": distance,
        "meals_served": mealsServed,
        "gst_percentage": gstPercentage,
        "gst_amount": gstAmount,
        "total_amount": totalAmount,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "pause_subscription_date":
            "${pauseSubscriptionDate.year.toString().padLeft(4, '0')}-${pauseSubscriptionDate.month.toString().padLeft(2, '0')}-${pauseSubscriptionDate.day.toString().padLeft(2, '0')}",
        "resume_subscription_date":
            "${resumeSubscriptionDate.year.toString().padLeft(4, '0')}-${resumeSubscriptionDate.month.toString().padLeft(2, '0')}-${resumeSubscriptionDate.day.toString().padLeft(2, '0')}",
        "holidays": holidays,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "kitchen": kitchen.toJson(),
        "catalog": catalog.toJson(),
        "transaction": transaction.toJson(),
      };
}

class Catalog {
  Catalog({
    this.id,
    this.mealName,
    this.mealCategory,
  });

  int id;
  String mealName;
  MealCategory mealCategory;

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
        id: json["id"],
        mealName: json["meal_name"],
        mealCategory: json["meal_category"] == null ? null : MealCategory.fromJson(json["meal_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meal_name": mealName,
        "meal_category": mealCategory == null ? null : mealCategory.toJson(),
      };
}

class MealCategory {
  MealCategory({
    this.id,
    this.category,
  });

  int id;
  String category;

  factory MealCategory.fromJson(Map<String, dynamic> json) => MealCategory(
        id: json["id"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
      };
}

class Kitchen {
  Kitchen({
    this.id,
    this.kitchenName,
    this.address,
    this.fssaiNumber,
    this.zone,
  });

  int id;
  String kitchenName;
  String address;
  String fssaiNumber;
  Zone zone;

  factory Kitchen.fromJson(Map<String, dynamic> json) => Kitchen(
        id: json["id"],
        kitchenName: json["kitchen_name"],
        address: json["address"],
        fssaiNumber: json["fssai_number"],
        zone: Zone.fromJson(json["zone"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kitchen_name": kitchenName,
        "address": address,
        "fssai_number": fssaiNumber,
        "zone": zone.toJson(),
      };
}

class Zone {
  Zone({
    this.zoneName,
    this.city,
  });

  String zoneName;
  String city;

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        zoneName: json["zone_name"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "zone_name": zoneName,
        "city": city,
      };
}

class Transaction {
  Transaction({
    this.id,
    this.razorpayOrderId,
    this.sheplatesOrderId,
    this.transactionId,
  });

  int id;
  String razorpayOrderId;
  String sheplatesOrderId;
  String transactionId;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        razorpayOrderId: json["razorpay_order_id"],
        sheplatesOrderId: json["sheplates_order_id"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "razorpay_order_id": razorpayOrderId,
        "sheplates_order_id": sheplatesOrderId,
        "transaction_id": transactionId,
      };
}

class PastSubscription {
  PastSubscription({
    this.sheplatesOrderId,
    this.orders,
  });

  String sheplatesOrderId;
  List<PastSubscriptionOrder> orders;

  factory PastSubscription.fromJson(Map<String, dynamic> json) => PastSubscription(
        sheplatesOrderId: json["sheplates_order_id"],
        orders: List<PastSubscriptionOrder>.from(json["orders"].map((x) => PastSubscriptionOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sheplates_order_id": sheplatesOrderId,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class PastSubscriptionOrder {
  PastSubscriptionOrder({
    this.id,
    this.userId,
    this.mealPlanId,
    this.kitchenId,
    this.preferredDeliveryTime,
    this.quantity,
    this.duration,
    this.basicSubscriptionPrice,
    this.days,
    this.totalMealCount,
    this.delieveryCharges,
    this.packagingCharges,
    this.mealsServed,
    this.gstPercentage,
    this.gstAmount,
    this.totalAmount,
    this.startDate,
    this.endDate,
    this.pauseSubscriptionDate,
    this.resumeSubscriptionDate,
    this.holidays,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.kitchen,
    this.catalog,
    this.transaction,
  });

  int id;
  int userId;
  int mealPlanId;
  int kitchenId;
  String preferredDeliveryTime;
  int quantity;
  String duration;
  int basicSubscriptionPrice;
  int days;
  int totalMealCount;
  int delieveryCharges;
  int packagingCharges;
  int mealsServed;
  int gstPercentage;
  double gstAmount;
  int totalAmount;
  DateTime startDate;
  DateTime endDate;
  DateTime pauseSubscriptionDate;
  DateTime resumeSubscriptionDate;
  String holidays;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic kitchen;
  Catalog catalog;
  Transaction transaction;

  factory PastSubscriptionOrder.fromJson(Map<String, dynamic> json) => PastSubscriptionOrder(
        id: json["id"],
        userId: json["user_id"],
        mealPlanId: json["meal_plan_id"],
        kitchenId: json["kitchen_id"],
        preferredDeliveryTime: json["preferred_delivery_time"],
        quantity: json["quantity"],
        duration: json["duration"],
        basicSubscriptionPrice: json["basic_subscription_price"],
        days: json["days"],
        totalMealCount: json["total_meal_count"],
        delieveryCharges: json["delievery_charges"],
        packagingCharges: json["packaging_charges"],
        mealsServed: json["meals_served"],
        gstPercentage: json["gst_percentage"],
        gstAmount: json["gst_amount"].toDouble(),
        totalAmount: json["total_amount"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        pauseSubscriptionDate: DateTime.parse(json["pause_subscription_date"]),
        resumeSubscriptionDate: DateTime.parse(json["resume_subscription_date"]),
        holidays: json["holidays"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        kitchen: json["kitchen"],
        catalog: Catalog.fromJson(json["catalog"]),
        transaction: Transaction.fromJson(json["transaction"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "meal_plan_id": mealPlanId,
        "kitchen_id": kitchenId,
        "preferred_delivery_time": preferredDeliveryTime,
        "quantity": quantity,
        "duration": duration,
        "basic_subscription_price": basicSubscriptionPrice,
        "days": days,
        "total_meal_count": totalMealCount,
        "delievery_charges": delieveryCharges,
        "packaging_charges": packagingCharges,
        "meals_served": mealsServed,
        "gst_percentage": gstPercentage,
        "gst_amount": gstAmount,
        "total_amount": totalAmount,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "pause_subscription_date":
            "${pauseSubscriptionDate.year.toString().padLeft(4, '0')}-${pauseSubscriptionDate.month.toString().padLeft(2, '0')}-${pauseSubscriptionDate.day.toString().padLeft(2, '0')}",
        "resume_subscription_date":
            "${resumeSubscriptionDate.year.toString().padLeft(4, '0')}-${resumeSubscriptionDate.month.toString().padLeft(2, '0')}-${resumeSubscriptionDate.day.toString().padLeft(2, '0')}",
        "holidays": holidays,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "kitchen": kitchen,
        "catalog": catalog.toJson(),
        "transaction": transaction.toJson(),
      };
}