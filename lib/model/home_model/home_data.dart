import '../banners_model.dart';
import '../products_ model.dart';

class HomeData {
  List<Banners>? banners = [];

  List<Products>? products = [];

   HomeData.fromJson(Map<String, dynamic>? json) {
  //   _banners = json?['banners'].forEach((v) => Banners.fromJson(v));
  //   _products = json?['products'].forEach((v) =>  Products.fromJson(v));
     banners =
        json?['banners'].map<Banners>((v) => Banners.fromJson(v)).toList();
    products =
        json?['products'].map<Products>((v) => Products.fromJson(v)).toList();
  }
}
