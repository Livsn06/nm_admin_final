import 'package:admin/models/ailments/md_ailment.dart';
import 'package:admin/models/plant/md_plant.dart';

// {
//     "id": 49,
//     "plant_id": 5,
//     "treatment_id": 16,
//     "created_at": "2024-12-06T08:15:14.000000Z",
//     "updated_at": "2024-12-06T08:15:14.000000Z"
// },
class PlantTreatmentModel {
  int? id;
  int? plant_id;
  int? treatment_id;
  String? created_at;
  String? updated_at;

  PlantTreatmentModel({
    this.id,
    this.plant_id,
    this.treatment_id,
    this.created_at,
    this.updated_at,
  });

  static List<PlantTreatmentModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((json) => PlantTreatmentModel.fromJson(json)).toList();
  }

  static PlantTreatmentModel fromJson(Map<String, dynamic> json) {
    return PlantTreatmentModel(
      id: json['id'],
      plant_id: int.tryParse(json['plant_id'].toString()) ?? 0,
      treatment_id: int.tryParse(json['treatment_id'].toString()) ?? 0,
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plant_id'] = plant_id.toString();
    data['treatment_id'] = treatment_id.toString();
    return data;
  }
}
