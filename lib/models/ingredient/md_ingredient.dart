class IngredientModel {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  IngredientModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  static List<IngredientModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => IngredientModel.fromJson(json)).toList();
  }

  static List<dynamic> listToMap(List<IngredientModel> list) {
    if (list.isEmpty) return [];
    var mapList = [];
    for (var l in list) {
      var temp = l.id == null || l.id == 0
          ? {"name": l.name, "description": l.description}
          : {"id": l.id, "name": l.name, "description": l.description};
      mapList.add(temp);
    }
    return mapList;
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
