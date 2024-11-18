// {
//                     "id": 1,
//                     "name": "Step 1 for Aloe Vera Remedy 1",
//                     "description": "Step 1 for Aloe Vera Remedy 1 involves following specific instructions for the remedy.",
//                     "remedy_id": 1,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },

import 'package:admin/controllers/ct_remedy.dart';
import 'package:admin/models/remedies/md_remedy.dart';

class StepModel {
  int? id;
  String? name;
  int? remedy_id;
  String? description;
  String? created_at;
  String? updated_at;

  StepModel({
    this.id,
    this.name,
    this.remedy_id,
    this.description,
    this.created_at,
    this.updated_at,
  });

  static List<StepModel> fromJsonList(List<dynamic> list) {
    if (list.isEmpty) return [];
    return list.map((item) => StepModel.fromJson(item)).toList();
  }

  StepModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.parse(json['id'].toString()) : 0;
    name = json['name'];
    remedy_id = json['remedy_id'] == null ? int.parse(json['remedy_id']) : 0;
    description = json['description'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['name'] = name;
    data['remedy_id'] = remedy_id.toString();
    data['description'] = description;
    return data;
  }
}
