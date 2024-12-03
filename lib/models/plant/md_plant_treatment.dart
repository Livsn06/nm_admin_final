import 'package:admin/models/ailments/md_ailment.dart';
import 'package:admin/models/plant/md_plant.dart';

class PlantTreatmentModel {
  int? id;
  PlantModel? plant;
  AilmentModel? ailment;
  String? created_at;
  String? updated_at;

  PlantTreatmentModel({
    this.id,
    this.plant,
    this.ailment,
    this.created_at,
    this.updated_at,
  });

  static List<PlantTreatmentModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((json) => PlantTreatmentModel.fromJson(json)).toList();
  }

  static PlantTreatmentModel fromJson(Map<String, dynamic> json) {
    return PlantTreatmentModel(
      id: json['id'] ?? 0,
      plant: json['plant'] != null ? PlantModel.fromJson(json['plant']) : null,
      ailment: json['treatment'] != null
          ? AilmentModel.fromJson(json['treatment'])
          : null,
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plant_id'] = plant!.id;
    data['treatment_id'] = ailment!.id;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plant_id'] = plant!.id.toString();
    data['treatment_id'] = ailment!.id.toString();
    return data;
  }
}
