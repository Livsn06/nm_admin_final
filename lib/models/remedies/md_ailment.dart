//  {
//                     "id": 1,
//                     "name": "Aloe Vera Remedy 1 Ailment 1",
//                     "type": "Common",
//                     "description": "Description for Aloe Vera Remedy 1 Ailment 1",
//                     "remedy_id": 1,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },

class AilmentModel {
  int? id;
  String? name;
  String? type;
  String? description;
  int? remedy_id;
  int? plant_id;
  String? created_at;
  String? updated_at;

  AilmentModel({
    this.id,
    this.name,
    this.type,
    this.description,
    this.remedy_id,
    this.plant_id,
    this.created_at,
    this.updated_at,
  });

  static List<AilmentModel> fromPlantJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((json) => AilmentModel.fromPlantJson(json)).toList();
  }

  static List<AilmentModel> fromRemedyJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((json) => AilmentModel.fromRemedyJson(json)).toList();
  }

  AilmentModel.fromRemedyJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    remedy_id = json['remedy_id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
  AilmentModel.fromPlantJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.parse(json['id'].toString()) : 0;
    name = json['name'];
    type = json['type'];
    description = json['description'];
    plant_id =
        json['plant_id'] != null ? int.parse(json['plant_id'].toString()) : 0;
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toPlantJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['plant_id'] = plant_id.toString();

    return data;
  }

  Map<String, dynamic> toRemedyJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['remedy_id'] = plant_id.toString();

    return data;
  }
}
