import 'package:intl/intl.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? role;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = _arrangeDate(json['created_at']);
    updatedAt = _arrangeDate(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'email_verified_at': emailVerifiedAt,
    };
  }

  String? _arrangeDate(String? date) {
    if (date == null) {
      return null;
    }
    return DateFormat('MMMM d, yyyy').format(DateTime.parse(date));
  }
}
