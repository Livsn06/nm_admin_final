import 'package:admin/api/auth/api_forgot.dart';

class PlantLocalNameModel {
  int? id;
  int? plant_id;
  String? name;

  PlantLocalNameModel({this.id, this.plant_id, this.name});

  static List<PlantLocalNameModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((item) => PlantLocalNameModel.fromJson(item)).toList();
  }

  PlantLocalNameModel.fromJson(Map<String, dynamic> json) {
    id = _toID(json['id']);
    plant_id = _toPlantID(json['plant_id']);
    name = _toName(json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'plant_id': plant_id.toString(),
      'name': name,
    };
  }

  Map<String, dynamic> toDeleteJson() {
    return {
      'plant_id': plant_id.toString(),
    };
  }

  _toID(jID) {
    if (jID == null) return 0;
    return int.parse(jID.toString());
  }

  _toName(jName) {
    if (jName == null) return 'Undefined';
    return jName.toString().trim();
  }

  _toPlantID(jID) {
    if (jID == null) return 0;
    return int.parse(jID.toString());
  }
}
