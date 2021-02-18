class CheckOutResponse {
  int status;
  String message;
  Data data;

  CheckOutResponse({this.status, this.message, this.data});

  CheckOutResponse.fromJson(Map<String, dynamic> json) {
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
  Orders orders;
  Gst gst;

  Data({this.orders, this.gst});

  Data.fromJson(Map<String, dynamic> json) {
    orders =
    json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
    gst = json['gst'] != null ? new Gst.fromJson(json['gst']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.toJson();
    }
    if (this.gst != null) {
      data['gst'] = this.gst.toJson();
    }
    return data;
  }
}

class Orders {
  int mealsServed;
  int gstPercentage;
  String createdAt;
  String updatedAt;
  int id;
  int userId;
  String mealPlanId;
  String preferredDeliveryTime;
  String quantity;
  String duration;
  int basicSubscriptionPrice;
  int totalMealCount;
  num delieveryCharges;
  num packagingCharges;
  num gstAmount;
  num totalAmount;
  String startDate;
  String endDate;
  String status;
  String holidays;

  Orders(
      {this.mealsServed,
        this.gstPercentage,
        this.createdAt,
        this.updatedAt,
        this.id,
        this.userId,
        this.mealPlanId,
        this.preferredDeliveryTime,
        this.quantity,
        this.duration,
        this.basicSubscriptionPrice,
        this.totalMealCount,
        this.delieveryCharges,
        this.packagingCharges,
        this.gstAmount,
        this.totalAmount,
        this.startDate,
        this.endDate,
        this.status,
        this.holidays});

  Orders.fromJson(Map<String, dynamic> json) {
    mealsServed = json['meals_served'];
    gstPercentage = json['gst_percentage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    userId = json['user_id'];
    mealPlanId = json['meal_plan_id'];
    preferredDeliveryTime = json['preferred_delivery_time'];
    quantity = json['quantity'];
    duration = json['duration'];
    basicSubscriptionPrice = json['basic_subscription_price'];
    totalMealCount = json['total_meal_count'];
    delieveryCharges = json['delievery_charges'];
    packagingCharges = json['packaging_charges'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    holidays = json['holidays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meals_served'] = this.mealsServed;
    data['gst_percentage'] = this.gstPercentage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['meal_plan_id'] = this.mealPlanId;
    data['preferred_delivery_time'] = this.preferredDeliveryTime;
    data['quantity'] = this.quantity;
    data['duration'] = this.duration;
    data['basic_subscription_price'] = this.basicSubscriptionPrice;
    data['total_meal_count'] = this.totalMealCount;
    data['delievery_charges'] = this.delieveryCharges;
    data['packaging_charges'] = this.packagingCharges;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['holidays'] = this.holidays;
    return data;
  }
}

class Gst {
  double cgst;
  double sgst;

  Gst({this.cgst, this.sgst});

  Gst.fromJson(Map<String, dynamic> json) {
    cgst = json['cgst'];
    sgst = json['sgst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    return data;
  }
}