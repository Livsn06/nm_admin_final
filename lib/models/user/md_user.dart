import 'package:get/get.dart';

// 'name',
// 'email',
// 'password',
// 'type',
// 'status',
// 'avatar',
// 'total_update',
// 'total_delete',
// 'total_create',
class UserModel {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? confirm_password;
  String? type;
  String? avatar;
  String? status;
  int? total_update;
  int? total_delete;
  int? total_create;
  String? email_verified_at;
  String? updated_at;
  String? created_at;

  UserModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.confirm_password,
    this.type = 'Admin',
    this.avatar,
    this.status,
    this.total_update,
    this.total_delete,
    this.total_create,
    this.email_verified_at,
    this.updated_at,
    this.created_at,
  });

  static List<UserModel> listFromJson(List<dynamic> json) {
    return json.map((e) => UserModel.fromJson(e)).toList();
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    firstname = _splitName(_toString(json['name']), ',', 0);
    lastname = _splitName(_toString(json['name']), ',', 1);

    email = _toString(json['email']);
    type = _toString(json['type']);
    avatar = _toString(json['avatar']);
    status = _toString(json['status']);
    total_delete = _toInt(json['total_delete']);
    total_update = _toInt(json['total_update']);
    total_create = _toInt(json['total_create']);

    // email_verified_at = json['email_verified_at'];
    created_at = _toString(json['created_at']);
    updated_at = _toString(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': _arrangeName(firstname!, lastname!),
      'email': _arrangeEmail(email!),
      'type': type,
      'avatar': avatar,
      'status': status,
      'total_update': total_update,
      'total_delete': total_delete,
      'total_create': total_create,
      'created_at': created_at,
      'updated_at': updated_at
      // 'email_verified_at': email_verified_at,
    };
  }

  Map<String, dynamic> registerToJson() {
    return {
      'name': _arrangeName(firstname!, lastname!),
      'email': _arrangeEmail(email!),
      'password': password,
      'password_confirmation': confirm_password,
      'type': type
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
      'name': _arrangeName(firstname!, lastname!),
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

  Map<String, dynamic> updateWorkStatusToJson() {
    return {
      'total_update': total_update,
      'total_delete': total_delete,
      'total_create': total_create,
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

  _splitName(value, split, index) {
    return isNull(value) ? null : value.toString().split(split)[index].trim();
  }

  _arrangeName(String firstName, String lastName) {
    return '${_capitalizeBySpace(firstName)},${_capitalizeBySpace(lastName)}';
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
