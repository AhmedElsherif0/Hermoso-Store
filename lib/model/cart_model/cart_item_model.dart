class CartItemModel {
  late int id;
  late String name;
  late String image;
  late num price = 0.0;
  late num oldPrice = 0.0;
  late num total;
  late num taxes;
  late int quantity = 1;

  CartItemModel.custom();

  CartItemModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.oldPrice,
      required this.quantity,
      required this.image});

  CartItemModel.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['title'];
    price = json?['price'];
    oldPrice = json?['oldPrice'];
    quantity = json?['quantity'];
    image = json?['image'];
    total = json?['total'];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "oldPrice": oldPrice,
        "quantity": quantity,
        "image": image,
      };
}
