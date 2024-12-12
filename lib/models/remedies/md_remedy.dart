import 'dart:convert';

import '../ailments/md_ailment.dart';
import '../ingredient/md_ingredient.dart';
import '../plant/md_plant.dart';
import 'md_rating.dart';

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
  double? average_rating;
  List<dynamic>? steps;
  List<dynamic>? side_effect;
  List<dynamic>? usage_remedy;
  List<IngredientModel>? ingredients;
  List<dynamic>? image_path;
  List<RatingModel>? user_ratings;
  List<AilmentModel>? treatments;
  List<PlantModel>? tagged_plants;
  String? created_at;
  String? updated_at;

  RemedyModel({
    this.id,
    this.name,
    this.type,
    this.description,
    this.status,
    this.average_rating,
    this.ingredients,
    this.steps,
    this.side_effect,
    this.usage_remedy,
    this.image_path,
    this.user_ratings,
    this.treatments,
    this.tagged_plants,
    this.created_at,
    this.updated_at,
  });

  static List<RemedyModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => RemedyModel.fromJson(item)).toList();
  }

  RemedyModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString()) ?? 0;
    name = json['name'] ?? 'Unknown';
    type = json['type'] ?? 'Unknown';
    description = json['description'] ?? 'None';
    status = json['status'] ?? 'ctive';
    average_rating = double.tryParse(json['average_rating'].toString()) ?? 0;
    ingredients = IngredientModel.listFromJson(json['ingredients'] ?? []);
    steps = json['step'] ?? [];
    side_effect = json['side_effect'] ?? [];
    usage_remedy = json['usage_remedy'] ?? [];
    image_path = json['image_path'] ?? [];
    user_ratings = RatingModel.listFromJson(json['user_ratings'] ?? []);
    treatments = AilmentModel.listFromJson(json['treatments'] ?? []);
    tagged_plants = PlantModel.listFromJson(json['tagged_plants'] ?? []);
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, String> toCreateRemedyJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name.toString();
    data['type'] = type.toString();
    data['description'] = description.toString();
    data['status'] = status?.toString() ?? 'active';
    data['step'] = jsonEncode(steps);
    data['usage_remedy'] = jsonEncode(usage_remedy);
    data['side_effect'] = jsonEncode(side_effect);
    data['ingredients'] =
        jsonEncode(IngredientModel.listToMap(ingredients ?? []));
    data['tagged_plants'] =
        jsonEncode(tagged_plants!.map((e) => e.id.toString()).join(','));
    data['treatments'] = jsonEncode(treatments!.map((e) => e.id).join(','));
    return data;
  }

  Map<String, dynamic> toUpdateStatusJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
