import 'package:admin/models/remedies/md_remedy.dart';

class StepModel {
  int? id;
  RemedyModel? remedy;
  String? description;

  StepModel({this.id, this.remedy, this.description});

  StepModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remedy =
        json['remedy'] != null ? RemedyModel.fromJson(json['remedy']) : null;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (remedy != null) {
      data['remedyId'] = remedy!.id;
    }
    data['description'] = description;
    return data;
  }
}
