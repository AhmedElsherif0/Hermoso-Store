class FavoriteProduct {
  late int id;

  late num price;

  late num oldPrice;

  late num discount;

  String? image;

  String? name;

  FavoriteProduct();

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
