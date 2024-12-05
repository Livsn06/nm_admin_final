class RemedyPlantModel {
  int? id;
  int? plant_id;
  int? remedy_id;
  String? created_at;
  String? updated_at;

  RemedyPlantModel({
    this.id,
    this.remedy_id,
    this.plant_id,
    this.created_at,
    this.updated_at,
  });

  static List<RemedyPlantModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((item) => RemedyPlantModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remedy_id'] = remedy_id.toString();
    data['plant_id'] = plant_id.toString();
    return data;
  }

  RemedyPlantModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    remedy_id = int.tryParse(json['remedy_id'].toString());
    plant_id = int.tryParse(json['plant_id'].toString());
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}
