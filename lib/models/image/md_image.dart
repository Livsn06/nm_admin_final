import 'dart:convert';
import 'dart:typed_data';

class ImageModel {
  String? file_name;
  String? mime_type;
  Uint8List? image_data;

  ImageModel({this.file_name, this.mime_type, this.image_data});

  static List<ImageModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((json) => ImageModel.fromJson(json)).toList();
  }

  ImageModel.fromJson(Map<String, dynamic> json) {
    file_name = _fileName(json['file_name']);
    mime_type = _fileType(json['mime_type']);
    image_data = _fileData(json['image_data']);
  }

  _fileName(value) {
    if (value == null) return 'Undefined';
    return value.toString();
  }

  _fileType(value) {
    if (value == null) return 'Undefined';
    return value.toString();
  }

  _fileData(value) {
    if (value == null) return null;
    return base64Decode(value);
  }
}
