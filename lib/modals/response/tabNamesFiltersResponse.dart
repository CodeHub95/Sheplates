class TabNamesFilters {
  TabNamesFilters({this.status, this.message, this.data});

  int status;
  String message;
  Data data;

  factory TabNamesFilters.fromJson(Map<String, dynamic> json) => TabNamesFilters(
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
  Data({this.mealCategory});

  MealCategory mealCategory;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mealCategory: MealCategory.fromJson(json["mealCategory"]),
      );

  Map<String, dynamic> toJson() => {
        "mealCategory": mealCategory.toJson(),
      };
}

class MealCategory {
  MealCategory({this.count, this.rows});

  int count;
  List<RowData> rows;

  factory MealCategory.fromJson(Map<String, dynamic> json) => MealCategory(
        count: json["count"],
        rows: List<RowData>.from(json["rows"].map((x) => RowData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class RowData {
  RowData({this.id, this.category, this.cutOfTime, this.createdAt, this.updatedAt, this.categoryTimeSlots});

  int id;
  String category;
  String cutOfTime;
  DateTime createdAt;
  DateTime updatedAt;
  List<CategoryTimeSlot> categoryTimeSlots;

  factory RowData.fromJson(Map<String, dynamic> json) => RowData(
        id: json["id"],
        category: json["category"],
        cutOfTime: json["cut_of_time"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        categoryTimeSlots:
            List<CategoryTimeSlot>.from(json["category_time_slots"].map((x) => CategoryTimeSlot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "cut_of_time": cutOfTime,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "category_time_slots": List<dynamic>.from(categoryTimeSlots.map((x) => x.toJson())),
      };
}

class CategoryTimeSlot {
  CategoryTimeSlot({this.timeSlot});

  String timeSlot;

  factory CategoryTimeSlot.fromJson(Map<String, dynamic> json) => CategoryTimeSlot(
        timeSlot: json["time_slot"],
      );

  Map<String, dynamic> toJson() => {
        "time_slot": timeSlot,
      };
}
