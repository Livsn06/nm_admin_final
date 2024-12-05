class IngredientModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  IngredientModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  static List<IngredientModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => IngredientModel.fromJson(json)).toList();
  }

  IngredientModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString()) ?? 0;
    name = json['name']?.toString() ?? 'None';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
