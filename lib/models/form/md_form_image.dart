import 'dart:html' as html;
import 'dart:typed_data';

class FormImageModel {
  String? name;
  html.File? file;
  Uint8List? bytes;

  FormImageModel({this.name, this.file, this.bytes});
}
