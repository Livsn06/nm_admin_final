class ResponseModel {
  bool success;
  bool? api_success;
  String? message;
  String? token;
  Map<String, dynamic>? data;
  Map<String, dynamic>? errors;

  ResponseModel({
    required this.success,
    this.api_success,
    this.message,
    this.token,
    this.data,
    this.errors,
  });

  //
  factory ResponseModel.fromJson(Map<String, dynamic> json,
          {required bool success}) =>
      ResponseModel(
        success: success,
        api_success: json["success"],
        message: json["message"],
        token: json["access_token"],
        data: json["data"] == null ? null : json["data"][0],
        errors: json["errors"],
      );
}
