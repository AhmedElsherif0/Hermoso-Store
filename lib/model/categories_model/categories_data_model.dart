import 'category.dart';

class CategoriesDataModel {
  int? currentPage;
  List<Category> categoryList = [];

  CategoriesDataModel();

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    categoryList = List<Category>.from(json["data"].map((x) => Category.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(categoryList.map((x) => x.toJson())),
      };
}
