// 'name' => $request->name ?? null,
//           'path' => $coverPath,
//           'plant_id' => $request->plant_id,

class ApiImageModel {
  int? id;
  String? name;
  String? path;
  int? plant_id;
  int? remedy_id;

  ApiImageModel({this.id, this.name, this.path, this.plant_id, this.remedy_id});

  static List<ApiImageModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ApiImageModel.fromJson(json)).toList();
  }

  ApiImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.parse(json['id'].toString()) : null;
    name = json['name'];
    path = json['path'];
    plant_id = json['plant_id'] != null
        ? int.parse(json['plant_id'].toString())
        : null;
    remedy_id = json['remedy_id'] != null
        ? int.parse(json['remedy_id'].toString())
        : null;
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name.toString();
    data['plant_id'] = plant_id.toString();
    data['remedy_id'] = remedy_id.toString();
    return data;
  }
}
