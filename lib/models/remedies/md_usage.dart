import 'package:admin/models/remedies/md_remedy.dart';

class UsageModel {
  int? id;
  RemedyModel? remedy;
  String? usage;

  UsageModel({this.id, this.remedy, this.usage});

  UsageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remedy =
        json['remedy'] != null ? RemedyModel.fromJson(json['remedy']) : null;
    usage = json['usage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (remedy != null) {
      data['remedyId'] = remedy!.id;
    }
    data['usage'] = usage;
    return data;
  }
}
