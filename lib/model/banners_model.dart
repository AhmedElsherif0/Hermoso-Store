
import 'category_model.dart';

class Banners {
  int? _id;
  String? _image;
  Category? _category;

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get image => _image;
  set image(String? image) => _image = image;
 Category? get category => _category;
  set category(Category? category) => _category = category;

  Banners.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    image = json?['image'];
    _category =
        json?['category'] != null ? Category.fromJson(json?['category']) : null;
  }
}
