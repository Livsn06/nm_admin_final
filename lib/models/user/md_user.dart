import 'package:admin/api/user/api_user_get.dart';
import 'package:intl/intl.dart';

// "success": true,
//     "message": "User found.",
//     "user": {
//         "id": 1,
//         "name": "Joel Gutlay",
//         "email": "joel.gutlay@email.com",
//         "role": "Admin",
//         "email_verified_at": null,
//         "created_at": "2024-10-30T13:35:27.000000Z",
//         "updated_at": "2024-10-30T13:35:27.000000Z"
//     }
class UserModel {
  int? id;
  String? name;
  String? email;
  String? role;
  String? email_verified_at;
  String? updated_at;
  String? created_at;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.email_verified_at,
    this.updated_at,
    this.created_at,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    email_verified_at = json['email_verified_at'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'email_verified_at': email_verified_at,
    };
  }
}
