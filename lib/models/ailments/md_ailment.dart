class AilmentModel {
  int? id;
  String? name;
  String? type;
  String? description;
  String? createdAt;
  String? updatedAt;

  AilmentModel({
    this.id,
    this.name,
    this.type,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  static List<AilmentModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => AilmentModel.fromJson(json)).toList();
  }

  AilmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? 'None';
    type = json['type'] ?? 'None';
    description = json['description'] ?? 'None';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
