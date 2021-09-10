
import 'category_model.dart';

class Banners {
  int? id;
  String? image;
  Category? category;



  Banners.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    image = json?['image'];
    category =
        json?['category'] != null ? Category.fromJson(json?['category']) : null;
  }
}
