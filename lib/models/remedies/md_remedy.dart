import 'package:admin/models/remedies/md_rating.dart';
import 'package:admin/models/remedies/md_step.dart';
import 'package:admin/models/remedies/md_usage.dart';
import 'package:admin/models/remedies/md_video.dart';

import '../plant/md_plant.dart';

class RemedyModel {
  int? id;
  String? name;
  String? type;
  String? treatment;
  String? description;
  RatingModel? rating;
  UsageModel? usage;
  StepModel? step;
  VideoModel? video;

  RemedyModel(
      {this.id,
      this.name,
      this.type,
      this.treatment,
      this.description,
      this.rating,
      this.usage,
      this.step,
      this.video});

  RemedyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    treatment = json['treatment'];
    description = json['description'];
    rating =
        json['ratings'] != null ? RatingModel.fromJson(json['rating']) : null;
    usage = json['usages'] != null ? UsageModel.fromJson(json['usage']) : null;
    step = json['steps'] != null ? StepModel.fromJson(json['step']) : null;
    video = json['videos'] != null ? VideoModel.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['treatment'] = treatment;
    data['description'] = description;
    return data;
  }
}
