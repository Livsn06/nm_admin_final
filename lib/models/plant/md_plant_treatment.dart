import 'package:admin/models/plant/md_plant.dart';

class PlantTreatmentModel {
  int? id;
  String? name;
  String? description;
  int? plant_id;
  String? created_at;
  String? updated_at;

  PlantTreatmentModel({
    this.id,
    this.name,
    this.description,
    this.plant_id,
    this.created_at,
    this.updated_at,
  });

  static List<PlantTreatmentModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList
        .map((json) => PlantTreatmentModel().fromJson(json))
        .toList();
  }

  PlantTreatmentModel fromJson(Map<String, dynamic> json) {
    return PlantTreatmentModel(
      id: _toID(json['id']),
      name: _toName(json['name']),
      description: _toDescription(json['description']),
      plant_id: _toPlant(json['plant_id']),
      created_at: _toCreatedAt(json['created_at']),
      updated_at: _toUpdatedAt(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['plant_id'] = plant_id.toString();
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    return data;
  }

  //-------------------
  _toID(jId) {
    if (jId == null) return 0;
    return int.parse(jId.toString());
  }

  _toName(jName) {
    if (jName == null) return 'Undefined';
    return jName.toString().trim();
  }

  _toDescription(jDesc) {
    if (jDesc == null) return 'None';
    return jDesc.toString().trim();
  }

  _toCreatedAt(jCreatedAt) {
    if (jCreatedAt == null) return 'Undefined';
    return jCreatedAt.toString().trim();
  }

  _toUpdatedAt(jUpdatedAt) {
    if (jUpdatedAt == null) return 'Undefined';
    return jUpdatedAt.toString().trim();
  }

  _toPlant(jPlant) {
    if (jPlant == null) return 0;
    return int.parse(jPlant.toString());
  }
}
