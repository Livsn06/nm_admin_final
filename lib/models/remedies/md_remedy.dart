import 'package:admin/models/image/md_image.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/models/remedies/md_step.dart';
import 'package:admin/models/remedies/md_usage.dart';
import 'package:admin/models/remedies/md_ingredient.dart';
import 'package:admin/models/user/md_user.dart';

import '../plant/md_plant.dart';

// {
//             "id": 4,
//             "name": "Peppermint Remedy 2",
//             "type": "Inhalation",
//             "description": "This remedy utilizes Peppermint for various health benefits.",
//             "effect": "Effect of Peppermint for general wellness",
//             "cover": "peppermint_remedy_2.jpg",
//             "ratings": 5,
//             "status": "Active",
//             "plant_id": 2,
//             "updated_by": 3,
//             "created_by": 2,
//             "created_at": "2024-10-31T10:19:00.000000Z",
//             "updated_at": "2024-10-31T10:19:00.000000Z",
//             "plant": {
//                 "id": 2,
//                 "name": "Peppermint",
//                 "scientific": "Mentha piperita",
//                 "description": "Peppermint is used for digestive issues and has a refreshing aroma.",
//                 "status": "Active",
//                 "cover": "peppermint.jpg",
//                 "likes": 20,
//                 "updated_by": 1,
//                 "created_by": 1,
//                 "created_at": "2024-10-31T10:19:00.000000Z",
//                 "updated_at": "2024-10-31T10:19:00.000000Z"
//             },
//             "ailments": [
//                 {
//                     "id": 13,
//                     "name": "Peppermint Remedy 2 Ailment 1",
//                     "type": "Common",
//                     "description": "Description for Peppermint Remedy 2 Ailment 1",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },
//                 {
//                     "id": 14,
//                     "name": "Peppermint Remedy 2 Ailment 2",
//                     "type": "Common",
//                     "description": "Description for Peppermint Remedy 2 Ailment 2",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },
//                 {
//                     "id": 15,
//                     "name": "Peppermint Remedy 2 Ailment 3",
//                     "type": "Common",
//                     "description": "Description for Peppermint Remedy 2 Ailment 3",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },
//                 {
//                     "id": 16,
//                     "name": "Peppermint Remedy 2 Ailment 4",
//                     "type": "Common",
//                     "description": "Description for Peppermint Remedy 2 Ailment 4",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },
//                 {
//                     "id": 17,
//                     "name": "Peppermint Remedy 2 Ailment 5",
//                     "type": "Common",
//                     "description": "Description for Peppermint Remedy 2 Ailment 5",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 }
//             ],
//             "steps": [
//                 {
//                     "id": 12,
//                     "name": "Step 1 for Peppermint Remedy 2",
//                     "description": "Step 1 for Peppermint Remedy 2 involves following specific instructions for the remedy.",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },
//                 {
//                     "id": 13,
//                     "name": "Step 2 for Peppermint Remedy 2",
//                     "description": "Step 2 for Peppermint Remedy 2 involves following specific instructions for the remedy.",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },
//                 {
//                     "id": 14,
//                     "name": "Step 3 for Peppermint Remedy 2",
//                     "description": "Step 3 for Peppermint Remedy 2 involves following specific instructions for the remedy.",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },
//                 {
//                     "id": 15,
//                     "name": "Step 4 for Peppermint Remedy 2",
//                     "description": "Step 4 for Peppermint Remedy 2 involves following specific instructions for the remedy.",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 }
//             ],
//             "usages": [
//                 {
//                     "id": 4,
//                     "name": "Usage for Peppermint Remedy 2",
//                     "type": "Compress",
//                     "description": "Use Peppermint Remedy 2 as directed. Follow the instructions carefully for best results.",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 }
//             ],
//             "ingredients": [
//                 {
//                     "id": 11,
//                     "name": "Pepper",
//                     "quantity": 6,
//                     "description": "This is a description for Peppermint Remedy 2 ingredient.",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },
//                 {
//                     "id": 12,
//                     "name": "Turmeric",
//                     "quantity": 8,
//                     "description": "This is a description for Peppermint Remedy 2 ingredient.",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },
//                 {
//                     "id": 13,
//                     "name": "Turmeric",
//                     "quantity": 4,
//                     "description": "This is a description for Peppermint Remedy 2 ingredient.",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 },
//                 {
//                     "id": 14,
//                     "name": "Green Tea Extract",
//                     "quantity": 4,
//                     "description": "This is a description for Peppermint Remedy 2 ingredient.",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:00.000000Z",
//                     "updated_at": "2024-10-31T10:19:00.000000Z"
//                 }
//             ],
//             "images": [
//                 {
//                     "id": 10,
//                     "name": "peppermint_remedy_2_image_1",
//                     "path": "images/peppermint_remedy_2/peppermint_remedy_2_image_1.jpg",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:01.000000Z",
//                     "updated_at": "2024-10-31T10:19:01.000000Z"
//                 },
//                 {
//                     "id": 11,
//                     "name": "peppermint_remedy_2_image_2",
//                     "path": "images/peppermint_remedy_2/peppermint_remedy_2_image_2.jpg",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:01.000000Z",
//                     "updated_at": "2024-10-31T10:19:01.000000Z"
//                 },
//                 {
//                     "id": 12,
//                     "name": "peppermint_remedy_2_image_3",
//                     "path": "images/peppermint_remedy_2/peppermint_remedy_2_image_3.jpg",
//                     "remedy_id": 4,
//                     "created_at": "2024-10-31T10:19:01.000000Z",
//                     "updated_at": "2024-10-31T10:19:01.000000Z"
//                 }
//             ]
//         },
class RemedyModel {
  int? id;
  String? name;
  String? type;
  String? description;
  String? status;
  PlantModel? plant;
  double? rating;
  String? effect;
  String? cover;
  List<AilmentModel>? treatment;
  List<UsageModel>? usage;
  List<StepModel>? steps;
  List<ApiImageModel>? images;
  List<IngredientModel>? ingredients;
  UserModel? user_create_by;
  UserModel? user_update_by;
  String? created_at;
  String? updated_at;

  RemedyModel({
    this.id,
    this.name,
    this.type,
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
    type = json['type'];
    description = json['description'];
    status = json['status'];
    plant = json['plant'] != null ? PlantModel.fromJson(json['plant']) : null;
    rating = json['ratings'] != null
        ? double.parse(json['ratings'].toString())
        : null;
    effect = json['effect'];
    cover = json['cover'];
    treatment = json['ailments'] != null
        ? AilmentModel.fromRemedyJsonList(json['ailments'])
        : null;
    usage =
        json['usages'] != null ? UsageModel.fromJsonList(json['usages']) : null;
    steps =
        json['steps'] != null ? StepModel.fromJsonList(json['steps']) : null;
    images = json['images'] != null
        ? ApiImageModel.listFromJson(json['images'])
        : null;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['description'] = description;
    data['status'] = status;
    data['plant_id'] = plant!.id;
    data['rating'] = rating;
    data['effect'] = effect;
    data['cover'] = cover;

    if (user_create_by != null) {
      data['create_by'] = user_create_by!.id;
    }
    if (user_update_by != null) {
      data['update_by'] = user_update_by!.id;
    }

    return data;
  }
}
