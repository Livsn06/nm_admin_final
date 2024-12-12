class RemedyImageModel {
  int? id;
  String? path;
  int? remedy_id;

  RemedyImageModel({this.id, this.path, this.remedy_id});

  //list of images json
  static List<RemedyImageModel> listFromJson(List<dynamic> json) {
    return json.map((e) => RemedyImageModel.fromJson(e)).toList();
  }

  RemedyImageModel.fromJson(Map<String, dynamic> json) {
    id = _toID(json['id']);
    path = _toPath(json['path']);
    remedy_id = _toID(json['remedy_id']);
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
