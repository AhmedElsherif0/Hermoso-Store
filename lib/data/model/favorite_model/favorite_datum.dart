import 'favorite_product.dart';


class FavoriteList {
 late int id;
  FavoriteProduct favoriteProduct = FavoriteProduct() ;

  FavoriteList();

  FavoriteList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    favoriteProduct = (json['product'] != null ? FavoriteProduct.fromJson(json['product'])
        : null)!;
  }
}

