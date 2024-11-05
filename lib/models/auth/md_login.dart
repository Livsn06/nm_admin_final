import 'package:get/get.dart';

class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, this.password = ''});

  //
  Map<String, dynamic> toJson() {
    return {
      'email': _arrangeEmail(email),
      'password': password,
    };
  }

  // factory LoginModel.fromJson(Map<String, dynamic> json) {
  //   return LoginModel(
  //     email: json['email'],
  //     password: json['password'],
  //   );
  // }

  String _arrangeEmail(String email) {
    return email.removeAllWhitespace.toLowerCase();
  }
}
