//  {
//                     "id": 1,
//                     "name": "Turmeric",
//                     "quantity": 2,
//                     "description": "This is a description for Aloe Vera Remedy 1 ingredient.",
//                     "remedy_id": 1,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },

class RemedyIngredientModel {
  int? id;
  int? ingredient_id;
  String? name;
  String? description;
  int? remedy_id;
  String? created_at;
  String? updated_at;

  RemedyIngredientModel({
    this.id,
    this.name,
    this.description,
    this.remedy_id,
    this.ingredient_id,
    this.created_at,
    this.updated_at,
  });

  static List<RemedyIngredientModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList
        .map((item) => RemedyIngredientModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() {
    print(
        'remedy_id: $remedy_id, ingredient_id: $ingredient_id, description: $description');

    final Map<String, dynamic> data = <String, dynamic>{};
    data['remedy_id'] = remedy_id.toString();
    data['ingredient_id'] = ingredient_id.toString();
    data['description'] = description.toString();
    return data;
  }

  RemedyIngredientModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    ingredient_id = int.tryParse(json['ingredient_id'].toString());
    remedy_id = int.tryParse(json['remedy_id'].toString());
    description = json['description'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}
