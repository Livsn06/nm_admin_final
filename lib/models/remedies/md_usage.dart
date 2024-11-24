import 'package:admin/models/remedies/md_remedy.dart';

// {
//                     "id": 1,
//                     "name": "Usage for Aloe Vera Remedy 1",
//                     "type": "Compress",
//                     "description": "Use Aloe Vera Remedy 1 as directed. Follow the instructions carefully for best results.",
//                     "remedy_id": 1,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 }
class UsageModel {
  int? id;
  String? name;
  String? description;
  int? remedy_id;
  String? created_at;
  String? updated_at;

  UsageModel({
    this.id,
    this.name,
    this.description,
    this.remedy_id,
    this.created_at,
    this.updated_at,
  });

  static List<UsageModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => UsageModel.fromJson(item)).toList();
  }

  UsageModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    name = json['name'];
    description = json['description'];
    remedy_id = int.tryParse(json['remedy_id'].toString());
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['remedy_id'] = remedy_id.toString();
    return data;
  }
}
