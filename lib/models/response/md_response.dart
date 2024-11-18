class ResponseModel {
  bool success;
  bool? clientError;
  String? message;
  String? token;
  Map<String, dynamic>? data;
  List<dynamic>? dataList = [];
  Map<String, dynamic>? errors;

  ResponseModel({
    required this.success,
    this.clientError,
    this.message,
    this.token,
    this.data,
    this.dataList,
    this.errors,
  });

  //
  factory ResponseModel.fromJson(Map<String, dynamic> json,
      {required bool success}) {
    return ResponseModel(
      success: success,
      message: json["message"],
      token: json["access_token"],
      data: json["data"],
      errors: json["errors"],
    );
  }

  //
  factory ResponseModel.dataFromJson(Map<String, dynamic> json,
      {required bool success}) {
    return ResponseModel(
      success: success,
      message: json["message"],
      data: json["data"],
      token: json["access_token"],
    );
  }
  factory ResponseModel.dataListFromJson(Map<String, dynamic> json,
      {required bool success}) {
    return ResponseModel(
      success: success,
      message: json["message"],
      dataList: json["data"],
      token: json["access_token"],
    );
  }

  factory ResponseModel.errorFromJson(Map<String, dynamic> json,
      {required bool success}) {
    return ResponseModel(
      success: success,
      message: json["message"],
      errors: json["errors"],
    );
  }

  factory ResponseModel.clientErrorFromJson(
      {required bool success, required String message}) {
    return ResponseModel(
      success: success,
      clientError: true,
      message: message,
    );
  }
}
