class SessionModel {
  bool success;
  bool? isActive;
  String? message;

  SessionModel({required this.success, this.isActive, this.message});

  factory SessionModel.fromJson(Map<String, dynamic> json,
      {required bool success}) {
    return SessionModel(
      success: success,
      isActive: json['is_active'],
      message: json['message'],
    );
  }
}
