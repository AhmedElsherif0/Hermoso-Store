import '../products/banners_model.dart';
import '../products/product_model.dart';

class HomeData {
  List<BannersModel> banners = [];

  List<ProductModel> products = [];

  HomeData();

  HomeData.fromJson(Map<String, dynamic>? json) {/*
    banners =
        json?['banners'].forEach<BannersModel>((v) => BannersModel.fromJson(v));
    products = json?['products']
        .forEach<ProductModel>((v) => ProductModel.fromJson(v));*/
      banners =
        json?['banners'].map<BannersModel>((v) => BannersModel.fromJson(v)).toList();
    products =
        json?['products'].map<ProductModel>((v) => ProductModel.fromJson(v)).toList();
  }
}
