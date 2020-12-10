class HolidayListResponse {
  HolidayData data;
  String message;
  int status;

  HolidayListResponse({this.data, this.message, this.status});

  factory HolidayListResponse.fromJson(Map<String, dynamic> json) {
    return HolidayListResponse(
      data: json['data'] != null ? HolidayData.fromJson(json['data']) : null,
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

class HolidayData {
  List<HolidayDateArray> dateArray;

  HolidayData({this.dateArray});

  factory HolidayData.fromJson(Map<String, dynamic> json) {
    return HolidayData(
      dateArray: json['dateArray'] != null
          ? (json['dateArray'] as List)
              .map((i) => HolidayDateArray.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dateArray != null) {
      data['dateArray'] = this.dateArray.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HolidayDateArray {
  String date;
  String holiday_name;

  HolidayDateArray({this.date, this.holiday_name});

  factory HolidayDateArray.fromJson(Map<String, dynamic> json) {
    return HolidayDateArray(
      date: json['date'],
      holiday_name: json['holiday_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['holiday_name'] = this.holiday_name;
    return data;
  }
}
