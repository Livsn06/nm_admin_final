import 'package:admin/models/image/md_image.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/models/remedies/md_step.dart';
import 'package:admin/models/remedies/md_usage.dart';
import 'package:admin/models/remedies/md_ingredient.dart';
import 'package:admin/models/user/md_user.dart';

import '../plant/md_plant.dart';

// {
//     "id": 1,
//     "name": "Herbal Decoction",
//     "description": "A decoction made from Kugon roots helps alleviate diarrhea by soothing the digestive system and reducing inflammation",
//     "treatment": "Diarrhea",
//     "status": "Active",
//     "usage": null,
//     "side_effect": null,
//     "ingredient": null,
//     "rating": 0,
//     "cover": null,
//     "update_id": null,
//     "create_id": 2,
//     "plant_id": 1,
//     "created_at": "2024-11-13T08:06:35.000000Z",
//     "updated_at": "2024-11-13T08:06:35.000000Z"
// },

class RemedyModel {
  int? id;
  String? name;
  String? description;
  String? status;
  PlantModel? plant;
  double? rating;
  String? effect;
  String? cover;
  List<AilmentModel>? treatment;
  List<UsageModel>? usage;
  List<StepModel>? steps;
  List<ImageModel>? images;
  List<IngredientModel>? ingredients;
  UserModel? user_create_by;
  UserModel? user_update_by;
  String? created_at;
  String? updated_at;

  RemedyModel({
    this.id,
    this.name,
    this.description,
    this.status,
    this.plant,
    this.rating,
    this.effect,
    this.cover,
    this.treatment,
    this.usage,
    this.steps,
    this.images,
    this.ingredients,
    this.user_create_by,
    this.user_update_by,
    this.created_at,
    this.updated_at,
  });

  static List<RemedyModel> fromJsonList(List<dynamic> list) {
    if (list.isEmpty) return [];
    return list.map((item) => RemedyModel.fromJson(item)).toList();
  }

  RemedyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.parse(json['id'].toString()) : null;
    name = json['name'];
    description = json['description'];
    status = json['status'];
    plant = json['plant'] != null ? PlantModel.fromJson(json['plant']) : null;
    rating =
        json['rating'] != null ? double.parse(json['rating'].toString()) : null;
    effect = json['effect'];
    cover = json['cover'];
    treatment = json['ailments'] != null
        ? AilmentModel.fromRemedyJsonList(json['ailments'])
        : null;
    usage =
        json['usages'] != null ? UsageModel.fromJsonList(json['usages']) : null;
    steps =
        json['steps'] != null ? StepModel.fromJsonList(json['steps']) : null;
    images =
        json['images'] != null ? ImageModel.fromJsonList(json['images']) : null;
    ingredients = json['ingredients'] != null
        ? IngredientModel.fromJsonList(json['ingredients'])
        : null;
    user_create_by = json['user_create_by'] != null
        ? UserModel.fromJson(json['user_create_by'])
        : null;
    user_update_by = json['user_update_by'] != null
        ? UserModel.fromJson(json['user_update_by'])
        : null;
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['id'] = id.toString();
    data['name'] = name.toString();
    data['description'] = description.toString();
    data['status'] = status.toString();
    data['plant_id'] = plant!.id.toString();
    data['rating'] = rating.toString();
    data['effect'] = effect.toString();
    data['cover'] = cover.toString();

    if (user_create_by != null) {
      data['created_by'] = user_create_by!.id.toString();
    }
    if (user_update_by != null) {
      data['updated_by'] = user_update_by!.id.toString();
    }

    return data;
  }
}
