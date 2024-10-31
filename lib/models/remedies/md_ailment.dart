class AilmentModel {
  int? id;
  String? name;
  String? type;
  String? description;

  AilmentModel({this.id, this.name, this.type, this.description});

  AilmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['description'] = description;
    return data;
  }
}
