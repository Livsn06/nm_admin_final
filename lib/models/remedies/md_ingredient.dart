//  {
//                     "id": 1,
//                     "name": "Turmeric",
//                     "quantity": 2,
//                     "description": "This is a description for Aloe Vera Remedy 1 ingredient.",
//                     "remedy_id": 1,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },

class IngredientModel {
  int? id;
  String? title;
  String? description;
  int? remedy_id;
  String? created_at;
  String? updated_at;

  IngredientModel({
    this.id,
    this.title,
    this.description,
    this.remedy_id,
    this.created_at,
    this.updated_at,
  });

  static List<IngredientModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];

    return jsonList.map((item) => IngredientModel.fromJson(item)).toList();
  }

  IngredientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    remedy_id = json['remedy_id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['remedy_id'] = remedy_id;
    return data;
  }
}
