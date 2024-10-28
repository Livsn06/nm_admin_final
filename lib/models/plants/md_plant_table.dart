import 'package:flutter/material.dart';

class PlantsTableModel {
  String? id;
  String? name;
  String? scientificName;
  String? description;
  String? ailment;
  String? cover;
  String? image;
  String? status;
  String? like;
  String? admin;
  String? createdAt;
  String? updatedAt;

  PlantsTableModel({
    this.id = 'ID',
    this.name = 'Name',
    this.scientificName = 'Scientific Name',
    this.description = 'Description',
    this.ailment = 'Ailment',
    this.cover = 'Pictures',
    this.status = 'Status',
    this.like = 'Likes',
    this.admin = 'Admin',
    this.createdAt = 'Created At',
    this.updatedAt = 'Last Updated',
  });

  List<String> toColumns() {
    return [
      id!,
      name!,
      scientificName!,
      description!,
      ailment!,
      cover!,
      status!,
      like!,
      admin!,
      updatedAt!,
      createdAt!,
    ];
  }
}
