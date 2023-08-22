class FavoriteProduct {
  late int id;

  late num price;

  late num oldPrice;

  late num discount;

  late String image;

  late String name;

  FavoriteProduct();

  FavoriteProduct.custom(
      {required this.id,
      required this.price,
      required this.oldPrice,
      required this.image,
      required this.name,
      required this.discount});

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
