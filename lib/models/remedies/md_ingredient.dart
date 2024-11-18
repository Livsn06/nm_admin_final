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
  String? name;
  String? description;
  int? remedy_id;
  String? created_at;
  String? updated_at;

  IngredientModel({
    this.id,
    this.name,
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
    id = json['id'] == null ? 0 : int.parse(json['id'].toString());
    name = json['name'];
    description = json['description'];
    remedy_id =
        json['remedy_id'] == null ? 0 : int.parse(json['remedy_id'].toString());
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['name'] = name;
    data['description'] = description;
    data['remedy_id'] = remedy_id.toString();
    return data;
  }
}
