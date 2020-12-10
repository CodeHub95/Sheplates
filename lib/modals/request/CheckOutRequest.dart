class CheckOutRequest {
    String duration;
    String end_date;
    String meal_plan_id;
    String preferred_delivery_time;
    String quantity;
    String start_date;

    CheckOutRequest({this.duration, this.end_date, this.meal_plan_id, this.preferred_delivery_time, this.quantity, this.start_date});

    factory CheckOutRequest.fromJson(Map<String, dynamic> json) {
        return CheckOutRequest(
            duration: json['duration'],
            end_date: json['end_date'],
            meal_plan_id: json['meal_plan_id'],
            preferred_delivery_time: json['preferred_delivery_time'],
            quantity: json['quantity'],
            start_date: json['start_date'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['duration'] = this.duration;
        data['end_date'] = this.end_date;
        data['meal_plan_id'] = this.meal_plan_id;
        data['preferred_delivery_time'] = this.preferred_delivery_time;
        data['quantity'] = this.quantity;
        data['start_date'] = this.start_date;
        return data;
    }
}