import 'package:admin/models/user/md_admin.dart';

class PlantsModel {
  int? id;
  String? name;
  String? scientificName;
  String? description;
  String? ailment;
  String? cover;
  List<String>? images;
  String? status;
  int? like;
  AdminModel? admin;
  String? createdAt;
  String? updatedAt;

  PlantsModel({
    this.id,
    this.name,
    this.scientificName,
    this.description,
    this.ailment,
    this.cover,
    this.images,
    this.status,
    this.like,
    this.admin,
    this.createdAt,
    this.updatedAt,
  });

  factory PlantsModel.fromJson(Map<String, dynamic> json) {
    return PlantsModel(
      id: json['id'],
      name: json['name'],
      scientificName: json['scientific'],
      description: json['description'],
      ailment: json['ailment'],
      cover: json['cover'],
      images: json['images'],
      status: json['status'],
      like: json['like'],
      admin: AdminModel.fromJson(json['admin']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['scientific'] = scientificName;
    data['description'] = description;
    data['ailment'] = ailment;
    data['cover'] = cover;
    data['status'] = status;
    data['like'] = like;
    data['uploaded_by'] = admin!.id;
    return data;
  }
}
