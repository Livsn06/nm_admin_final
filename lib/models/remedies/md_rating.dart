import 'package:admin/models/remedies/md_remedy.dart';

class RatingModel {
  int? id;
  RemedyModel? remedyId;
  double? rateNumber;

  RatingModel({this.id, this.remedyId, this.rateNumber});

  RatingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remedyId = json['remedyId'] != null
        ? RemedyModel.fromJson(json['remedyId'])
        : null;
    rateNumber = json['rateNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['remedyId'] = remedyId;
    data['rateNumber'] = rateNumber;
    return data;
  }
}
