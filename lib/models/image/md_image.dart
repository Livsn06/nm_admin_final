// 'name' => $request->name ?? null,
//           'path' => $coverPath,
//           'plant_id' => $request->plant_id,

class ApiImageModel {
  int? id;
  String? name;
  String? path;

  ApiImageModel({this.id, this.name, this.path});

  static List<ApiImageModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ApiImageModel.fromJson(json)).toList();
  }

  ApiImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['path'] = path;

    return data;
  }
}
