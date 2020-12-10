class CheckOutResponse {
  CheckOutData data;
  String message;
  int status;

  CheckOutResponse({this.data, this.message, this.status});

  factory CheckOutResponse.fromJson(Map<String, dynamic> json) {
    return CheckOutResponse(
      data: json['data'] != null ? CheckOutData.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class CheckOutData {
  Orders orders;

  CheckOutData({this.orders});

  factory CheckOutData.fromJson(Map<String, dynamic> json) {
    return CheckOutData(
      orders: json['orders'] != null ? Orders.fromJson(json['orders']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.toJson();
    }
    return data;
  }
}

class Orders {
  String createdAt;
  num delievery_charges;
  String duration;
  String end_date;
  num gst_amount;
  int gst_percentage;
  int id;
  String meal_plan_id;
  int meals_served;
  num packaging_charges;
  String preferred_delivery_time;
  String quantity;
  String start_date;
  String status;
  num total_amount;
  String updatedAt;
  int user_id;
  int total_meal_count;

  Orders(
      {this.createdAt,
      this.delievery_charges,
      this.total_meal_count,
      this.duration,
      this.end_date,
      this.gst_amount,
      this.gst_percentage,
      this.id,
      this.meal_plan_id,
      this.meals_served,
      this.packaging_charges,
      this.preferred_delivery_time,
      this.quantity,
      this.start_date,
      this.status,
      this.total_amount,
      this.updatedAt,
      this.user_id});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      createdAt: json['createdAt'],
      delievery_charges: json['delievery_charges'],
      total_meal_count: json['total_meal_count'],
      duration: json['duration'],
      end_date: json['end_date'],
      gst_amount: json['gst_amount'],
      gst_percentage: json['gst_percentage'],
      id: json['id'],
      meal_plan_id: json['meal_plan_id'],
      meals_served: json['meals_served'],
      packaging_charges: json['packaging_charges'],
      preferred_delivery_time: json['preferred_delivery_time'],
      quantity: json['quantity'],
      start_date: json['start_date'],
      status: json['status'],
      total_amount: json['total_amount'],
      updatedAt: json['updatedAt'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['delievery_charges'] = this.delievery_charges;
    data['duration'] = this.duration;
    data['end_date'] = this.end_date;
    data['gst_amount'] = this.gst_amount;
    data['gst_percentage'] = this.gst_percentage;
    data['id'] = this.id;
    data['meal_plan_id'] = this.meal_plan_id;
    data['total_meal_count'] = this.total_meal_count;
    data['meals_served'] = this.meals_served;
    data['packaging_charges'] = this.packaging_charges;
    data['preferred_delivery_time'] = this.preferred_delivery_time;
    data['quantity'] = this.quantity;
    data['start_date'] = this.start_date;
    data['status'] = this.status;
    data['total_amount'] = this.total_amount;
    data['updatedAt'] = this.updatedAt;
    data['user_id'] = this.user_id;
    return data;
  }
}
