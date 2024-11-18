import 'package:admin/models/image/md_image.dart';
import 'package:admin/models/user/md_user.dart';

// $table->id();
// $table->string('plant_name')->nullable(false);
// $table->string('scientific_name')->nullable();
// $table->text('description')->nullable();
// $table->text('additional_info')->nullable();
// $table->string('status')->nullable(false)->default('Pending');
// $table->boolean('is_accepted')->default(true);
// $table->foreignId('request_by')->constrained('users')->onDelete('cascade')->onUpdate('cascade');
// $table->foreignId('accept_by')->nullable()->constrained('users')->onDelete('cascade')->onUpdate('cascade');
// $table->timestamps();
class RequestPlantModel {
  int? id;
  String? plantName;
  String? scientific_name;
  String? description;
  List<ImageModel>? images;
  String? additional_info;
  String? status;
  bool? is_accepted;
  UserModel? request_by;
  UserModel? accept_by;
  String? created_at;
  String? updated_at;

  RequestPlantModel({
    this.id,
    this.plantName,
    this.scientific_name,
    this.description,
    this.images,
    this.additional_info,
    this.status,
    this.is_accepted,
    this.request_by,
    this.accept_by,
    this.created_at,
    this.updated_at,
  });

  static List<RequestPlantModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => RequestPlantModel.fromJson(json)).toList();
  }

  RequestPlantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantName = json['plant_name'];
    scientific_name = json['scientific_name'];
    description = json['description'];
    additional_info = json['additional_info'];
    status = json['status'];
    images =
        json['images'] != null ? ImageModel.fromJsonList(json['images']) : null;
    is_accepted = json['is_accepted'] == 1 ? true : false;
    request_by = json['request_by'] != null
        ? UserModel.fromJson(json['user_requestby'])
        : null;
    accept_by = json['accept_by'] != null
        ? UserModel.fromJson(json['user_acceptby'])
        : null;
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plant_name'] = plantName;
    data['scientific_name'] = scientific_name;
    data['description'] = description;
    data['additional_info'] = additional_info;
    data['status'] = status;
    data['is_accepted'] = is_accepted;
    data['request_by'] = request_by?.toJson();
    data['accept_by'] = accept_by?.toJson();
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    return data;
  }
}
