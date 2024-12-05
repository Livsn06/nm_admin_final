import 'dart:convert';

import 'package:admin/models/plant/md_plant.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/models/remedies/md_image.dart';
import 'package:admin/models/remedies/md_step.dart';
import 'package:admin/models/remedies/md_usage.dart';
import 'package:admin/models/remedies/md_ingredient.dart';
import 'package:admin/models/user/md_user.dart';

// 'name',
//   'description',
//   'status',
//   'rating',
//   'side_effect',
//   'plant_id',
//   'update_id',
//   'create_id',

class RemedyModel {
  int? id;
  String? name;
  String? type;
  String? description;
  String? status;
  int? rating;
  List<String>? side_effect;
  int? plant_id;
  PlantModel? plant;
  UserModel? update_by;
  UserModel? create_by;
  String? cover;
  List<String>? treatments;
  List<String>? usages;
  List<String>? steps;
  List<String>? ingredients;
  List<String>? images;

  RemedyModel({
    this.id,
    this.name,
    this.type,
    this.description,
    this.status,
    this.rating,
    this.side_effect,
    this.plant_id,
    this.plant,
    this.update_by,
    this.create_by,
    this.cover,
    this.treatments,
    this.usages,
    this.steps,
    this.ingredients,
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
    rating = int.tryParse(json['rating'].toString());
    plant_id = int.tryParse(json['plant_id'].toString());
    update_by = json['update_by'] != null
        ? UserModel.fromJson(json['update_by'])
        : null;
    create_by = json['create_by'] != null
        ? UserModel.fromJson(json['create_by'])
        : null;

    // treatments = json['treatments'] != null
    //     ? RemedyTreatmentModel.fromJsonList(json['treatments'] ?? [])
    //     : null;
    usages = json['usages'];
    steps = json['steps'];
    ingredients = json['ingredients'];
    images = json['images']?.toList() ?? [];
  }

  RemedyModel.fromJsonWithPlant(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    name = json['name'] ?? '';
    type = json['type'] ?? '';
    description = json['description'] ?? '';
    status = json['status'] ?? '';
    rating = int.tryParse(json['rating'].toString());
    plant_id = int.tryParse(json['plant_id'].toString());
    update_by = json['update_by'] != null
        ? UserModel.fromJson(json['update_by'])
        : null;
    create_by = json['create_by'] != null
        ? UserModel.fromJson(json['create_by'])
        : null;

    // treatments = json['treatments'] != null
    //     ? RemedyTreatmentModel.fromJsonList(json['treatments'] ?? [])
    //     : null;
    // usages = json['usages'] != null
    //     ? UsageModel.fromJsonList(json['usages'] ?? [])
    //     : null;
    // steps = json['steps'] != null
    //     ? StepModel.fromJsonList(json['steps'] ?? [])
    //     : null;
    // ingredients = json['ingredients'] != null
    //     ? IngredientModel.fromJsonList(json['ingredients'] ?? [])
    //     : null;
    plant = json['plant'] != null ? PlantModel.fromJson(json['plant']) : null;
    cover = json['cover'];
    // images = json['images'] != null
    //     ? RemedyImageModel.listFromJson(json['images'])
    //     : null;
  }
  Map<String, String> toCreateRemedyJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name.toString();
    data['type'] = type?.toString() ?? '';
    data['description'] = description?.toString() ?? '';
    data['status'] = status?.toString() ?? '';
    data['step'] = jsonEncode(steps);
    data['side_effect'] = jsonEncode(side_effect);
    return data;
  }

  Map<String, dynamic> toUpdateRemedyJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['description'] = description;
    data['plant_id'] = plant_id.toString();
    data['update_id'] = update_by!.id.toString();
    data['create_id'] = create_by!.id.toString();
    return data;
  }

  Map<String, dynamic> toUpdateStatusJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
