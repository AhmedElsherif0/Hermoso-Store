class ProductModel {
  late int id;
  late num price;
  late num oldPrice;
  late num discount;
  late String image;
  late String name;
  late bool inFavorites;
  late String description;
  late bool isInCart;

  ProductModel();

  ProductModel.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    price = json?['price'];
    oldPrice = json?['old_price'];
    discount = json?['discount'];
    image = json?['image'];
    name = json?['name'];
    inFavorites = json?['in_favorites'];
    description = json?['description'];
    isInCart = json?['in_cart'];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'price': price,
        'old_price': oldPrice,
        'image': image,
        'name': name,
        'discount': discount,
        'in_favorites': inFavorites,
        'description': description,
        'in_cart': isInCart,
      };
}
