class ErrorModel {
  String? email;
  String? password;

  ErrorModel({
    this.email,
    this.password,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] == null ? null : json['email'][0];
    password = json['password'] == null ? null : json['password'][0];
  }
}
