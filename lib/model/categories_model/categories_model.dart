import 'categories_data_model.dart';

class CategoriesModel {
  bool? status;
  CategoriesDataModel data = CategoriesDataModel();
  CategoriesModel();

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = (json['data'] != null
        ? CategoriesDataModel.fromJson(json["data"]) : null)!;
  }

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "data": data.toJson()
      };
}
