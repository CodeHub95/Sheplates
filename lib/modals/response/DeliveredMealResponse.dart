class DeliveredMealListResponse {
  int status;
  String message;
  Data data;

  DeliveredMealListResponse({this.status, this.message, this.data});

  DeliveredMealListResponse.fromJson(Map<String, dynamic> json) {
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
  List<LastPlanFeedback> lastPlanFeedback;

  Data({this.lastPlanFeedback});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['lastPlanFeedback'] != null) {
      lastPlanFeedback = new List<LastPlanFeedback>();
      json['lastPlanFeedback'].forEach((v) {
        lastPlanFeedback.add(new LastPlanFeedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastPlanFeedback != null) {
      data['lastPlanFeedback'] =
          this.lastPlanFeedback.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastPlanFeedback {
  int id;
  String startDate;
  String endDate;
  int mealsServed;
  Feedback feedback;

  LastPlanFeedback(
      {this.id, this.startDate, this.endDate, this.mealsServed, this.feedback});

  LastPlanFeedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    mealsServed = json['meals_served'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['meals_served'] = this.mealsServed;
    data['feedback'] = this.feedback;
    return data;
  }
}

class Feedback {
  int taste;
  int quantity;
  int packaging;
  int valueOfMoney;
  int deliveryExperience;

  Feedback({this.taste, this.quantity, this.packaging, this.valueOfMoney, this.deliveryExperience});

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
