import '../banners_model.dart';
import '../products_ model.dart';

class HomeData {
  List<Banners>? _banners = [];

  List<Products>? _products = [];

   HomeData.fromJson(Map<String, dynamic>? json) {
  //   banners = json?['banners'].forEach((v) => Banners.fromJson(v));
  //   products = json?['products'].forEach((v) =>  Products.fromJson(v));
     _banners =
        json?['banners'].map<Banners>((v) => Banners.fromJson(v)).toList();
    _products =
        json?['products'].map<Products>((v) => Products.fromJson(v)).toList();
  }
 List<Products>? get products => _products;

 set products(List<Products>? value) => _products = value;

  List<Banners>? get banners => _banners;

   set banners(List<Banners>? value) => _banners = value;
}
