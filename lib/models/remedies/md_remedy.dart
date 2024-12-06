import 'dart:convert';

import 'package:admin/models/remedies/md_ailment.dart';

// "data": [
//         {
//             "id": 1,
//             "name": "Remedy1",
//             "type": "Type Remedy1",
//             "description": "this is Remedy1description",
//             "status": "active",
//             "step": "[\"step1 desc\",\"step2 desc\"]",
//             "usage_remedy": "[\"usage1 desc\",\"usage2 desc\"]",
//             "side_effect": "[\"side effect 1 desc\",\"side effect 2 desc\"]",
//             "image": "[\"remedy_image\\/1733440688_Remedy11.jpg\"]",
//             "created_at": "2024-12-05T23:18:09.000000Z",
//             "updated_at": "2024-12-05T23:18:09.000000Z",
//             "treatments": [
//                 {
//                     "id": 1,
//                     "remedy_id": 1,
//                     "treatment_id": 5,
//                     "created_at": "2024-12-05T23:18:15.000000Z",
//                     "updated_at": "2024-12-05T23:18:15.000000Z"
//                 },
//                 {
//                     "id": 2,
//                     "remedy_id": 1,
//                     "treatment_id": 4,
//                     "created_at": "2024-12-05T23:18:17.000000Z",
//                     "updated_at": "2024-12-05T23:18:17.000000Z"
//                 }
//             ]
//         }
//     ]

class RemedyModel {
  int? id;
  String? name;
  String? type;
  String? description;
  String? status;
  List<dynamic>? usage_remedy;
  List<dynamic>? side_effect;
  List<RemedyTreatmentModel>? treatments;
  List<dynamic>? steps;
  List<dynamic>? images;
  String? created_at;
  String? updated_at;

  RemedyModel({
    this.id,
    this.name,
    this.type,
    this.description,
    this.status,
    this.steps,
    this.usage_remedy,
    this.side_effect,
    this.treatments,
    this.created_at,
    this.images,
  });

  static List<RemedyModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => RemedyModel.fromJson(item)).toList();
  }

  RemedyModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    name = json['name'] ?? '';
    type = json['type'] ?? '';
    description = json['description'] ?? '';
    status = json['status'] ?? '';
    steps = json['steps'] != null ? jsonDecode(json['step']).toList() : [];
    usage_remedy = json['usage_remedy'] != null
        ? jsonDecode(json['usage_remedy']).toList()
        : [];
    side_effect = json['side_effect'] != null
        ? jsonDecode(json['side_effect']).toList()
        : [];
    images = json['image'] != null ? jsonDecode(json['image']).toList() : [];
    treatments = json['treatments'] != null
        ? RemedyTreatmentModel.fromJsonList(json['treatments'])
        : [];
  }

  Map<String, String> toCreateRemedyJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name.toString();
    data['type'] = type?.toString() ?? '';
    data['description'] = description?.toString() ?? '';
    data['status'] = status?.toString() ?? '';
    data['step'] = jsonEncode(steps);
    data['usage_remedy'] = jsonEncode(usage_remedy);
    data['side_effect'] = jsonEncode(side_effect);
    return data;
  }

  Map<String, dynamic> toUpdateStatusJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
