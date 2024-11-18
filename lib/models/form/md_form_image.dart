import 'dart:html' as html;
import 'dart:typed_data';

class FormImageModel {
  int? id;
  String? name;
  html.File? file;
  Uint8List? bytes;

  FormImageModel({this.id, this.name, this.file, this.bytes});
}
