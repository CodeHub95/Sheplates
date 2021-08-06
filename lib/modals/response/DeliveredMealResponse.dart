class DeliveredMealListResponse {
  int status;
  String message;
  List<DeliveredData> data;

  DeliveredMealListResponse({this.status, this.message, this.data});

  DeliveredMealListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<DeliveredData>();
      json['data'].forEach((v) {
        data.add(new DeliveredData.fromJson(v));
      });
    }
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

class DeliveredData {
  int id;
  String startDate;
  String endDate;
  int mealsServed;
  Catalog catalog;
  Feedback feedback;

  DeliveredData(
      {this.id,
        this.startDate,
        this.endDate,
        this.mealsServed,
        this.catalog,
        this.feedback});

  DeliveredData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    mealsServed = json['meals_served'];
    catalog =
    json['catalog'] != null ? new Catalog.fromJson(json['catalog']) : null;
    feedback = json['feedback'] != null
        ? new Feedback.fromJson(json['feedback'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['meals_served'] = this.mealsServed;
    if (this.catalog != null) {
      data['catalog'] = this.catalog.toJson();
    }
    if (this.feedback != null) {
      data['feedback'] = this.feedback.toJson();
    }
    return data;
  }
}

class Catalog {
  String mealName;

  Catalog({this.mealName});

  Catalog.fromJson(Map<String, dynamic> json) {
    mealName = json['meal_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meal_name'] = this.mealName;
    return data;
  }
}

class Feedback {
  int taste;
  int quantity;
  int packaging;
  int valueOfMoney;
  int deliveryExperience;

  Feedback(
      {this.taste,
        this.quantity,
        this.packaging,
        this.valueOfMoney,
        this.deliveryExperience});

  Feedback.fromJson(Map<String, dynamic> json) {
    taste = json['taste'];
    quantity = json['quantity'];
    packaging = json['packaging'];
    valueOfMoney = json['value_of_money'];
    deliveryExperience = json['delivery_experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taste'] = this.taste;
    data['quantity'] = this.quantity;
    data['packaging'] = this.packaging;
    data['value_of_money'] = this.valueOfMoney;
    data['delivery_experience'] = this.deliveryExperience;
    return data;
  }
}
