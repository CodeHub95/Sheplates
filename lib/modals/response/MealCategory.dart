class MealCategory {
    String category;
    int id;

    MealCategory({this.category, this.id});

    factory MealCategory.fromJson(Map<String, dynamic> json) {
        return MealCategory(
            category: json['category'],
            id: json['id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category'] = this.category;
        data['id'] = this.id;
        return data;
    }
}