class ErrorModel {
  String? name;
  String? email;
  String? password;

  ErrorModel({
    this.name,
    this.email,
    this.password,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'][0];
    email = json['email'] == null ? null : json['email'][0];
    password = json['password'] == null ? null : json['password'][0];
  }
}
