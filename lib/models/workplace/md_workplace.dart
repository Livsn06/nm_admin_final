import 'package:admin/models/user/md_admin.dart';
import 'package:admin/models/user/md_user.dart';

class WorkplaceModel {
  int? id;
  String? plantName;
  String? scientificName;
  String? description;
  List<String>? images;
  UserModel? user;
  AdminModel? admin;
  String? status;
  String? createdAt;
  String? updatedAt;

  WorkplaceModel({
    this.id,
    this.plantName,
    this.scientificName,
    this.description,
    this.images,
    this.user,
    this.admin,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  WorkplaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantName = json['plant_name'];
    scientificName = json['scientific_name'];
    description = json['description'];
    images = json['images'];
    user = json['user'];
    admin = json['admin'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plant_name'] = plantName;
    data['scientific_name'] = scientificName;
    data['description'] = description;
    data['images'] = images;
    data['user_id'] = user;
    data['admin_id'] = admin;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
