// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

import 'categories_data_model.dart';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  bool? _status;
  CategoriesDataModel? _data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    _status = json["status"];
    _data = CategoriesDataModel.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() => {
        "status": _status,
        "data": _data!.toJson()
      };
}
