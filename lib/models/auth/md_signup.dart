import 'package:get/get.dart';

class SignupModel {
  String firstName;
  String lastName;
  String email;
  String role = 'Admin';
  String password;
  String confirmPassword;

  SignupModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.role = 'Admin',
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': _arrangeName(firstName, lastName),
      'email': _arrangeEmail(email),
      'role': role,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }

  String _arrangeName(String firstName, String lastName) {
    String fname = firstName.removeAllWhitespace.capitalizeFirst.toString();
    String lname = lastName.removeAllWhitespace.capitalizeFirst.toString();
    String fullname = '$fname $lname';
    return fullname;
  }

  String _arrangeEmail(String email) {
    return email.removeAllWhitespace.toLowerCase();
  }
}
