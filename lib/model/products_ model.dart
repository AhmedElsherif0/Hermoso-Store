class Products {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic  discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;


  Products.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    price = json?['price'];
    oldPrice = json?['old_price'];
    discount = json?['discount'];
    image = json?['image'];
    name = json?['name'];
    inFavorites = json?['in_favorites'];
    inCart = json?['in_cart'];
  }

/* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['price'] = this._price;
    data['old_price'] = this._oldPrice;
    data['discount'] = this._discount;
    data['image'] = this._image;
    data['name'] = this._name;
    data['description'] = this._description;
    data['images'] = this._images;
    data['in_favorites'] = this._inFavorites;
    data['in_cart'] = this._inCart;
    return data;
  }*/
}
