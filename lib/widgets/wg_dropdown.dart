import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

Widget customDropDown({
  required SingleValueDropDownController controller,
  required List dataValue,
  Function(dynamic)? onChange,
  required String hintText,
  String? Function(String?)? validator,
}) {
  return DropDownTextField(
    controller: controller,
    clearOption: true,
    enableSearch: true,
    clearIconProperty: IconProperty(color: Colors.green),
    searchTextStyle: const TextStyle(color: Colors.green),
    searchDecoration: InputDecoration(hintText: hintText),
    validator: validator,
    dropDownItemCount: 5,
    dropDownList: dataValue
        .map((plant) => DropDownValueModel(name: plant.name, value: plant))
        .toList(),
    onChanged: onChange,
  );
}
