import '../user/md_user.dart';

class LikeModel {
  int? id;
  int? like;
  UserModel? users;

  LikeModel({this.id, this.like, this.users});

  static List<LikeModel> listFromJson(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((json) => LikeModel.fromJson(json)).toList();
  }

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      like: json['like'],
      users: json['users'] != null ? UserModel.fromJson(json['users']) : null,
    );
  }
}
