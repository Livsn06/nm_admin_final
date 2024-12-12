//  {
//                     "id": 1,
//                     "name": "Aloe Vera Remedy 1 Ailment 1",
//                     "type": "Common",
//                     "description": "Description for Aloe Vera Remedy 1 Ailment 1",
//                     "remedy_id": 1,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },

class RemedyTreatmentModel {
  int? id;
  int? remedy_id;
  int? treatment_id;
  String? created_at;
  String? updated_at;

  RemedyTreatmentModel({
    this.id,
    this.remedy_id,
    this.treatment_id,
    this.created_at,
    this.updated_at,
  });

  static List<RemedyTreatmentModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((item) => RemedyTreatmentModel.fromJson(item)).toList();
  }

  RemedyTreatmentModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    remedy_id = int.tryParse(json['remedy_id'].toString());
    treatment_id = int.tryParse(json['treatment_id'].toString());
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remedy_id'] = remedy_id.toString();
    data['treatment_id'] = treatment_id.toString();
    return data;
  }
}
