class ChefChangeRequest {
  int subscription_plan_id;

  ChefChangeRequest({this.subscription_plan_id,  });

  ChefChangeRequest.fromJson(Map<String, dynamic> json) {
    subscription_plan_id = json['subscription_plan_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscription_plan_id'] = this.subscription_plan_id;

    return data;
  }
}