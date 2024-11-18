class PlantImageModel {
  int? id;
  String? path;
  int? plant_id;

  PlantImageModel({this.id, this.path, this.plant_id});

  //list of images json
  static List<PlantImageModel> listFromJson(List<dynamic> json) {
    return json.map((e) => PlantImageModel.fromJson(e)).toList();
  }

  PlantImageModel.fromJson(Map<String, dynamic> json) {
    id = _toID(json['id']);
    path = _toPath(json['path']);
    plant_id = _toID(json['plant_id']);
  }

  _toID(int? id) {
    if (id == null) return 0;
    return int.parse(id.toString());
  }

  _toPath(String? name) {
    if (name == null) return '';
    return name;
  }
}
