import 'dart:convert';

import 'package:admin/models/image/md_image.dart';
import 'package:admin/models/plant/md_plant_local_name.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:flutter/material.dart';

import 'md_image.dart';
import 'md_plant_treatment.dart';

// "message": "Plant fetch successfully",
//     "data": [
//         {
//             "id": 5,
//             "name": "Aloe vera",
//             "scientific_name": "Aloe barbadensis miller",
//             "local_name": "[\"Sabila\"]",
//             "description": "Aloe vera, often called the \"plant of immortality,\" is a succulent plant known for its thick, fleshy leaves filled with a gel-like substance. Native to arid regions, it thrives in warm climates and has been used for centuries in traditional medicine, skincare, and wellness practices.",
//             "status": "inactive",
//             "image_path": "[\"plant_image\\/1733209455_Aloe vera1.jpg\",\"plant_image\\/1733209456_Aloe vera2.jpg\",\"plant_image\\/1733209456_Aloe vera3.jpg\",\"plant_image\\/1733209456_Aloe vera4.jpg\"]",
//             "uploader_id": null,
//             "created_at": "2024-12-03T07:04:16.000000Z",
//             "updated_at": "2024-12-03T07:04:16.000000Z"
//         }
//     ]

class PlantModel {
  int? id;
  String? name;
  String? scientific_name;
  String? description;
  int? like;
  String? status;
  String? local_name;
  List<PlantTreatmentModel>? treatments;
  List<dynamic>? images;

  // admins
  int? uploader_id;

  String? created_at;
  String? updated_at;

  PlantModel({
    this.id,
    this.name,
    this.scientific_name,
    this.description,
    this.status,
    this.like,
    this.local_name,
    this.images,
    this.uploader_id,
    this.created_at,
    this.updated_at,
  });

  // List of plants from JSON
  static List<PlantModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => PlantModel.fromJson(json)).toList();
  }

  PlantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? 'None';
    scientific_name = json['scientific_name'] ?? 'None';
    description = json['description'] ?? 'None';
    status = json['status'] ?? 'inactive';
    local_name = json['local_name'] ?? 'None';
    images = json['image_path'] != null
        ? jsonDecode(json['image_path']).toList()
        : [];

    treatments = json['treatments'] != null
        ? PlantTreatmentModel.fromJsonList(json['treatments'])
        : [];

    uploader_id = json['uploader_id'] ?? 0;
    created_at = json['created_at'] ?? 'None';
    updated_at = json['updated_at'] ?? 'None';
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name.toString();
    data['scientific_name'] = scientific_name.toString();
    data['description'] = description.toString();
    data['local_name'] = local_name!.toString();
    data['uploader_id'] = uploader_id!.toString();
    return data;
  }

  Map<String, String> toCreatePlantJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name.toString();
    data['scientific_name'] = scientific_name.toString();
    data['description'] = description.toString();
    data['status'] = status ?? 'active';
    data['local_name'] = local_name!.toString();
    data['uploader_id'] = uploader_id!.toString();
    return data;
  }

  Map<String, dynamic> toUpdatePlantStatusJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status.toString();
    return data;
  }
}
