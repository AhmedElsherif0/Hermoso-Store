import '../../data/database/local_data/sqlite_database.dart';
import '../../data/model/cart_model/cart_item_model.dart';
import '../../data/model/products/product_model.dart';

abstract class CartRepository {
  Future<Map<int, CartItemModel>> updateCartRepo(
      {required int cartId, required bool isUpdated});

  Future<Map<int, CartItemModel>> clearCartMapRepo();

  Future<Map<int, CartItemModel>> removeItemRepo(int cartId);

  Future<Map<int, CartItemModel>> readDataBaseRepo();
}

class MockCartRepo extends CartRepository {
  final SqliteDatabase _sqliteDatabase = SqliteDatabase();
  CartItemModel cartItemModel = CartItemModel.custom();

  @override
  Future<Map<int, CartItemModel>> updateCartRepo(
      {required int cartId, required bool isUpdated}) async {
    cartItemModel.cartMap = Map.from(await readDataBaseRepo());
    _updateModel(cartId, isUpdated);
    if (cartItemModel.quantity > 0) {
       final updated = await _sqliteDatabase.update(
          product: cartItemModel, tableName: _sqliteDatabase.cartTableName);
      print('item updated $updated and itemId : ${cartItemModel.quantity}');
    }
    return cartItemModel.cartMap;
  }

  CartItemModel _updateModel(int cartId, bool isUpdated) {
    cartItemModel = cartItemModel.cartMap.update(
        cartId,
        (cartItem) => CartItemModel(
            id: cartItem.id,
            name: cartItem.name,
            price: cartItem.price,
            image: cartItem.image,
            oldPrice: cartItem.oldPrice,
            quantity: isUpdated
                ? ((cartItem.quantity == 1) ? 1 : cartItem.quantity - 1)
                : cartItem.quantity + 1));
    return cartItemModel;
  }

  @override
  Future<Map<int, CartItemModel>> readDataBaseRepo() async {
    final result =
        await _sqliteDatabase.readByTable(table: _sqliteDatabase.cartTableName);
    cartItemModel.cartMap =
        result.map((item) => CartItemModel.fromJson(item)).toList().asMap();
    print('cart screen cartMap is : ${cartItemModel.cartMap}');
    return cartItemModel.cartMap;
  }

  @override
  Future<Map<int, CartItemModel>> clearCartMapRepo() async {
    print('Cart items cleared');
    cartItemModel.cartMap.clear();
    await _sqliteDatabase.deleteAllItems(tableName: _sqliteDatabase.cartTableName);
    return cartItemModel.cartMap;
  }

  @override
  Future<Map<int, CartItemModel>> removeItemRepo(int cartId) async {
    cartItemModel.cartMap = Map.from(cartItemModel.cartMap);
    print('Cart remove one item');
    if (cartItemModel.cartMap.containsKey(cartId)) {
      cartItemModel.cartMap.removeWhere((item, product) => item == product.id);
      await _sqliteDatabase.deleteItem(
          id: cartId, tableName: _sqliteDatabase.cartTableName);
    }
    return cartItemModel.cartMap;
  }
}
