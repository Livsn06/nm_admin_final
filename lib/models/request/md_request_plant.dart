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
  String? scientific_name;
  String? description;
  List<dynamic>? images;
  UserModel? request_by;
  RequestPlantModel({
    this.id,
    this.scientific_name,
    this.description,
    this.images,
    this.request_by,
  });

  static List<RequestPlantModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => RequestPlantModel.fromJson(json)).toList();
  }

  RequestPlantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scientific_name = json['scientific_name'];
    description = json['description'];
    images = json['images'] ?? [];
    request_by =
        json['user_id'] != null ? UserModel.fromJson(json['user_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['scientific_name'] = scientific_name;
    data['description'] = description;
    data['images'] = images;
    data['user_id'] = request_by?.id;
    return data;
  }
}
