import 'package:get/get.dart';

// "message": "Login successful",
//   "access_token": "1|yhRpWjpixotHVVD3NOa7Tqyiq1dPpvYF3nhRwk2W6c00f696",
//   "data": {
//       "id": 1,
//       "name": "Joel Gutlay",
//       "email": "jo@email.com",
//       "email_verified_at": null,
//       "role": "admin",
//       "status": "active",
//       "avatar": null,
//       "phone": null,
//       "address": null,
//       "created_at": "2024-12-03T05:34:23.000000Z",
//       "updated_at": "2024-12-03T05:34:23.000000Z"
//   }
class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? confirm_password;
  String? role;
  String? avatar;
  String? status;
  String? phone;
  String? address;
  String? email_verified_at;
  String? updated_at;
  String? created_at;
  String? access_token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.confirm_password,
    this.role = 'Admin',
    this.avatar,
    this.status,
    this.phone,
    this.address,
    this.email_verified_at,
    this.updated_at,
    this.created_at,
    this.access_token,
  });

  static List<UserModel> listFromJson(List<dynamic> json) {
    return json.map((e) => UserModel.fromJson(e)).toList();
  }

  static UserModel fromJson(Map<String, dynamic> json, {String? accessToken}) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'] ?? '',
      status: json['status'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      created_at: json['created_at'] ?? '',
      updated_at: json['updated_at'] ?? '',
      email_verified_at: json['email_verified_at'] ?? '',
      access_token: accessToken ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': _arrangeEmail(email!),
      'type': role,
      'avatar': avatar,
      'status': status,
      'phone': phone,
      'address': address,
      'created_at': created_at,
      'updated_at': updated_at,
      'email_verified_at': email_verified_at,
    };
  }

  Map<String, dynamic> registerToJson() {
    return {
      'name': name,
      'email': _arrangeEmail(email!),
      'password': password,
      'password_confirmation': confirm_password,
      'role': 'admin',
      'status': 'inactive',
    };
  }

  Map<String, dynamic> loginToJson() {
    return {
      'email': _arrangeEmail(email!),
      'password': password,
    };
  }

  Map<String, dynamic> updateToJson() {
    return {
      'name': name,
      'password': password,
      'password_confirmation': confirm_password,
    };
  }

  Map<String, dynamic> deleteToJson() {
    return {
      'email': _arrangeEmail(email!),
    };
  }

  Map<String, dynamic> changePasswordToJson() {
    return {
      'email': _arrangeEmail(email!),
      'password': password,
      'password_confirmation': confirm_password,
    };
  }

  Map<String, dynamic> updateStatusToJson() {
    return {
      'status': status,
    };
  }

//
//===========================
  bool isNull(value) {
    return value == null;
  }

  _toInt(value) {
    return isNull(value) ? null : int.parse(value.toString());
  }

  _toString(value) {
    return isNull(value) ? null : value.toString();
  }

  _arrangeEmail(String email) {
    return email.removeAllWhitespace.toLowerCase();
  }

  _capitalizeBySpace(String value) {
    var splitStr = value.toLowerCase().split(' ');

    for (var i = 0; i < splitStr.length; i++) {
      splitStr[i] = splitStr[i].trim().capitalizeFirst.toString();
    }
    return value = splitStr.join(' ');
  }
}
