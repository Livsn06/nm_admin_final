import 'package:admin/models/image/md_image.dart';
import 'package:admin/models/plant/md_plant_local_name.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:flutter/material.dart';

import 'md_image.dart';
import 'md_plant_treatment.dart';

// {
//             "id": 71,
//             "name": "Almond",
//             "scientific_name": "Almonia",
//             "description": "This almonia is better than almond and better than any of you!.",
//             "like": 0,
//             "status": "Inactive",
//             "cover": "Almond_1731677825_67374e81a031f.jpg",
//             "request_id": null,
//             "update_id": null,
//             "create_id": 4,
//             "created_at": "2024-11-15T13:37:01.000000Z",
//             "updated_at": "2024-11-15T13:37:07.000000Z",
//             "local_names": [
//                 {
//                     "id": 56,
//                     "name": "Almonde",
//                     "plant_id": 71,
//                     "created_at": "2024-11-15T13:37:03.000000Z",
//                     "updated_at": "2024-11-15T13:37:03.000000Z"
//                 },
//                 {
//                     "id": 57,
//                     "name": "Alimon",
//                     "plant_id": 71,
//                     "created_at": "2024-11-15T13:37:04.000000Z",
//                     "updated_at": "2024-11-15T13:37:04.000000Z"
//                 }
//             ],
//             "treatments": [
//                 {
//                     "id": 25,
//                     "name": "Cough",
//                     "description": "this is cough",
//                     "plant_id": 71,
//                     "created_at": "2024-11-15T13:37:02.000000Z",
//                     "updated_at": "2024-11-15T13:37:02.000000Z"
//                 },
//                 {
//                     "id": 26,
//                     "name": "Head ache",
//                     "description": "this is headache",
//                     "plant_id": 71,
//                     "created_at": "2024-11-15T13:37:03.000000Z",
//                     "updated_at": "2024-11-15T13:37:03.000000Z"
//                 }
//             ],
//             "images": [
//                 {
//                     "id": 9,
//                     "path": "Almond_1731677828_67374e843e415.jpg",
//                     "plant_id": 71,
//                     "created_at": "2024-11-15T13:37:08.000000Z",
//                     "updated_at": "2024-11-15T13:37:08.000000Z"
//                 },
//                 {
//                     "id": 10,
//                     "path": "Almond_1731677829_67374e8554cf4.JPG",
//                     "plant_id": 71,
//                     "created_at": "2024-11-15T13:37:09.000000Z",
//                     "updated_at": "2024-11-15T13:37:09.000000Z"
//                 },
//                 {
//                     "id": 11,
//                     "path": "Almond_1731677830_67374e863658a.jfif",
//                     "plant_id": 71,
//                     "created_at": "2024-11-15T13:37:10.000000Z",
//                     "updated_at": "2024-11-15T13:37:10.000000Z"
//                 },
//                 {
//                     "id": 12,
//                     "path": "Almond_1731677831_67374e8702421.jfif",
//                     "plant_id": 71,
//                     "created_at": "2024-11-15T13:37:11.000000Z",
//                     "updated_at": "2024-11-15T13:37:11.000000Z"
//                 }
//             ],
//             "create_by": {
//                 "id": 4,
//                 "name": "Joel,Gutlay",
//                 "email": "jo@email.com",
//                 "type": "Admin",
//                 "status": "Active",
//                 "avatar": null,
//                 "total_plant_request": "0",
//                 "total_remedy_request": "0",
//                 "total_update": "0",
//                 "total_delete": "0",
//                 "total_create": "0",
//                 "email_verified_at": null,
//                 "created_at": "2024-11-14T10:53:00.000000Z",
//                 "updated_at": "2024-11-14T11:00:21.000000Z"
//             },
//             "update_by": null,
//             "requests_info": null
//         }

class PlantModel {
  int? id;
  String? name;
  String? scientific_name;
  String? description;
  int? like;
  String? status;
  String? cover;
  List<PlantLocalNameModel>? local_name;
  List<PlantImageModel>? images;
  List<PlantTreatmentModel>? ailments;

  // admins
  UserModel? create_by;
  UserModel? update_by;

  String? created_at;
  String? updated_at;

  PlantModel({
    this.id,
    this.name,
    this.scientific_name,
    this.description,
    this.status,
    this.cover,
    this.like,
    this.local_name,
    this.images,
    this.ailments,
    this.update_by,
    this.create_by,
    this.created_at,
    this.updated_at,
  });

  // List of plants from JSON
  static List<PlantModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => PlantModel.fromJson(json)).toList();
  }

  PlantModel.fromJson(Map<String, dynamic> json) {
    id = _toID(json['id']);
    name = _toName(json['name']);
    scientific_name = _toScientificName(json['scientific_name']);
    description = _toDescription(json['description']);
    status = _toStatus(json['status']);
    cover = _toCover(json['cover']);
    like = _toLike(json['like']);
    images = _toImages(json['images']);
    ailments = _toAilments(json['treatments']);
    local_name = _toLocalNames(json['local_names']);
    create_by = _toUser(json['create_by']);
    update_by = _toUser(json['update_by']);
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name.toString();
    data['scientific'] = scientific_name.toString();
    data['description'] = description.toString();
    data['created_by'] = create_by!.id.toString();
    return data;
  }

  Map<String, dynamic> toCreatePlantJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name.toString();
    data['scientific_name'] = scientific_name.toString();
    data['description'] = description.toString();
    data['create_id'] = create_by!.id.toString();
    return data;
  }

  Map<String, dynamic> toUpdatePlantJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name.toString();
    data['description'] = description.toString();
    data['create_id'] = create_by!.id.toString();
    data['update_id'] = update_by!.id.toString();
    return data;
  }

  Map<String, dynamic> toUpdatePlantStatusJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status.toString();
    return data;
  }

  _toID(jID) {
    if (jID == null) return 0;
    return int.parse(jID.toString());
  }

  _toName(jName) {
    if (jName == null) return 'Unknown';
    return jName.toString().trim();
  }

  _toScientificName(jName) {
    if (jName == null) return 'Unknown';
    return jName.toString().trim();
  }

  _toDescription(jDescription) {
    if (jDescription == null) return 'None';
    return jDescription.toString().trim();
  }

  _toStatus(jStatus) {
    if (jStatus == null) return 'Inactive';
    return jStatus.toString().trim();
  }

  _toLike(jLike) {
    if (jLike == null) return 0;
    return int.parse(jLike.toString());
  }

  _toCover(jCover) {
    if (jCover == null) return null;
    return jCover.toString();
  }

  _toImages(jImages) {
    if (jImages == null) return null;
    return PlantImageModel.listFromJson(jImages);
  }

  _toAilments(jAilments) {
    if (jAilments == null) return null;
    return PlantTreatmentModel.fromJsonList(jAilments);
  }

  _toLocalNames(jLocalNames) {
    if (jLocalNames == null) return null;
    return PlantLocalNameModel.fromJsonList(jLocalNames);
  }

  _toUser(jUsers) {
    if (jUsers == null) return null;
    return UserModel.fromJson(jUsers);
  }
}
