import '../user/md_user.dart';

class RatingModel {
  int? id;
  double? rate;
  UserModel? user;

  RatingModel({this.id, this.rate, this.user});

  static List<RatingModel> listFromJson(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((json) => RatingModel.fromJson(json)).toList();
  }

  RatingModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(['id'].toString()) ?? 0;
    rate = double.tryParse(json['rate'].toString()) ?? 0;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
}
