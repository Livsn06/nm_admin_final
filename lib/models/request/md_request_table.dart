import 'package:flutter/material.dart';

class RequestTableModel {
  String? id;
  String? plantName;
  String? scientificName;
  String? description;
  String? image;
  String? user;
  String? admin;
  String? status;
  String? createdAt;
  String? updatedAt;

  RequestTableModel({
    this.id = 'Request ID',
    this.plantName = 'Plant Name',
    this.scientificName = 'Scientific Name',
    this.description = 'Description',
    this.image = 'Image',
    this.user = 'Request By',
    this.admin = 'Handle By',
    this.status = 'Status',
    this.createdAt = 'Created At',
    this.updatedAt = 'Updated At',
  });

  List<String> toColumns() {
    return [
      id!,
      plantName!,
      scientificName!,
      description!,
      image!,
      user!,
      admin!,
      status!,
      updatedAt!,
      createdAt!,
    ];
  }
}
