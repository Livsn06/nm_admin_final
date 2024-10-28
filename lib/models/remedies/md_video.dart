import 'package:admin/models/remedies/md_remedy.dart';

class VideoModel {
  int? id;
  RemedyModel? remedy;
  String? video;

  VideoModel({this.id, this.remedy, this.video});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remedy =
        json['remedy'] != null ? RemedyModel.fromJson(json['remedy']) : null;
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (remedy != null) {
      data['remedyID'] = remedy!.id;
    }
    data['video'] = video;
    return data;
  }
}
