
import '../categories_model/category.dart';

class BannersModel {
  int? id;
  String? image;
  Category? category;

  BannersModel.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    image = json?['image'];
    category =
        json?['category'] != null ? Category.fromJson(json?['category']) : null;
  }


}
