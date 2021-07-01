class MainCategoryResponse {
  int status;
  String message;
  List<Category> data;

  MainCategoryResponse({this.status, this.message, this.data});

  factory MainCategoryResponse.fromJson(Map<String, dynamic> json) => MainCategoryResponse(
        status: json["status"],
        message: json["message"],
        data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.type,
  });

  int id;
  String type;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}
