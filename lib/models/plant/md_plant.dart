import 'package:admin/models/image/md_image.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:flutter/material.dart';

// "id": 6,
// "name": "Ginger",
// "scientific": "Zingiber officinale",
// "description": "Ginger is widely used for its medicinal properties, especially for digestive issues.",
// "status": "Active",
// "cover": "ginger.jpg",
// "likes": 18,
// "updated_by": 3,
// "created_by": 3,
// "created_at": "2024-10-30T13:35:31.000000Z",
// "updated_at": "2024-10-30T13:35:31.000000Z",
// "images": [
//     {
//         "id": 20,
//         "name": "ginger_image_1",
//         "path": "images/ginger/ginger_image_1.jpg",
//         "plant_id": 6,
//         "created_at": "2024-10-30T13:35:32.000000Z",
//         "updated_at": "2024-10-30T13:35:32.000000Z"
//     },
//     {
//         "id": 21,
//         "name": "ginger_image_2",
//         "path": "images/ginger/ginger_image_2.jpg",
//         "plant_id": 6,
//         "created_at": "2024-10-30T13:35:32.000000Z",
//         "updated_at": "2024-10-30T13:35:32.000000Z"
//     },
//     {
//         "id": 22,
//         "name": "ginger_image_3",
//         "path": "images/ginger/ginger_image_3.jpg",
//         "plant_id": 6,
//         "created_at": "2024-10-30T13:35:32.000000Z",
//         "updated_at": "2024-10-30T13:35:32.000000Z"
//     },
//     {
//         "id": 23,
//         "name": "ginger_image_4",
//         "path": "images/ginger/ginger_image_4.jpg",
//         "plant_id": 6,
//         "created_at": "2024-10-30T13:35:32.000000Z",
//         "updated_at": "2024-10-30T13:35:32.000000Z"
//     }
// ],
// "user_create_by": {
//     "id": 3,
//     "name": "Aron Jumawan",
//     "email": "aron.jumawan@email.com",
//     "role": "Admin",
//     "email_verified_at": null,
//     "created_at": "2024-10-30T13:35:28.000000Z",
//     "updated_at": "2024-10-30T13:35:28.000000Z"
// },
// "user_update_by": {
//     "id": 3,
//     "name": "Aron Jumawan",
//     "email": "aron.jumawan@email.com",
//     "role": "Admin",
//     "email_verified_at": null,
//     "created_at": "2024-10-30T13:35:28.000000Z",
//     "updated_at": "2024-10-30T13:35:28.000000Z"
// }
// }

class PlantModel {
  int? id;
  String? name;
  String? scientific;
  String? description;
  String? status;
  String? cover;
  int? likes;
  List<ApiImageModel>? images;
  List<AilmentModel>? ailments;

  // admins
  UserModel? user_update_by;
  UserModel? user_create_by;

  String? created_at;
  String? updated_at;

  PlantModel({
    this.id,
    this.name,
    this.scientific,
    this.description,
    this.status,
    this.cover,
    this.likes,
    this.user_update_by,
    this.user_create_by,
    this.created_at,
    this.updated_at,
  });

  // List of plants from JSON
  static List<PlantModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => PlantModel.fromJson(json)).toList();
  }

  PlantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    scientific = json['scientific'];
    description = json['description'];
    status = json['status'];
    cover = json['cover'];
    likes = json['likes'];
    images = ApiImageModel.listFromJson(json['images']);
    user_create_by = UserModel.fromJson(json['user_create_by']);
    user_update_by = UserModel.fromJson(json['user_update_by']);
    //
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['scientific'] = scientific;
    data['description'] = description;
    data['status'] = status;
    data['cover'] = cover;
    data['likes'] = likes;
    data['updated_by'] = user_update_by?.id!;

    return data;
  }
}

///
///
///
///
///

class PlantsTableModel {
  String? id;
  String? name;
  String? scientific;
  String? description;
  String? status;
  String? cover;
  String? likes;
  String? created_at;
  String? updated_at;

  // admins
  String? updated_by;
  String? created_by;

  PlantsTableModel({
    this.id = 'ID',
    this.name = 'Name',
    this.scientific = 'Scientific Name',
    this.description = 'Description',
    this.cover = 'Pictures',
    this.status = 'Status',
    this.likes = 'Likes',
    //
    this.updated_by = 'Updated By',
    this.created_by = 'Created By',
    //
    this.updated_at = 'Last Updated',
    this.created_at = 'Created At',
  });

  // List of plants from JSON
  //to list

  List<String> toColumns() {
    return [
      id!,
      name!,
      scientific!,
      description!,
      cover!,
      status!,
      likes!,
      updated_by!,
      created_by!,
      updated_at!,
      created_at!,
    ];
  }
}
