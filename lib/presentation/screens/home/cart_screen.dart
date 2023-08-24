import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/back_ios_button.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/custom_action_appbar.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/custom_elevated_button.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/empty_screen.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/row_text_and_number.dart';
import 'package:hermoso_store/presentation/widgets/show_snack_bar.dart';

import '../../../domain/cubit/global_cubit/cart/cart_cubit.dart';
import '../../../domain/cubit/global_cubit/products/products_cubit.dart';
import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../../utils/colors.dart';
import '../../views/cart_item.dart';
import '../../widgets/custom_widgets/loading_widget.dart';

class CartScreen extends StatefulWidget with SnackBarMixin {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart-Screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartCubit _cartCubit(context) => BlocProvider.of<CartCubit>(context);

  ProductsCubit _productCubit(context) => BlocProvider.of<ProductsCubit>(context);

  SettingsCubit _settingsCubit(context) => BlocProvider.of<SettingsCubit>(context);

  void _onDismissed(context, cartId, index) async {
    int keyIndex = _cartCubit(context).cartItemModel.cartMap.keys.elementAt(
        _cartCubit(context).cartItemModel.cartMap.values.toList()[index].id);
    int valueId = _cartCubit(context).cartItemModel.cartMap.values.toList()[index].id;
    _productCubit(context)
        .toggleProductCartIcon(_productCubit(context).findCartById(cartId));
    _cartCubit(context).removeCartItem(cartId);
  }

  @override
  Widget build(BuildContext context) {
    final cartMap = _cartCubit(context).cartItemModel.cartMap;
    return Scaffold(
      appBar: CustomAppBar()
          .changeAppAndStatusBarColor(isDark: _settingsCubit(context).isDarkMode),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Spacer(),
            Expanded(
                flex: 3,
                child: CartHeader(isDark: _settingsCubit(context).isDarkMode)),
            Expanded(
              flex: 14,
              child: BlocBuilder<CartCubit, CartStates>(
                builder: (context, state) {
                  print('cart screen builder is : ${state.toString()}');
                  if (state is CartLoadingState) const LoadingWidget();
                  print('cartMap Values is : ${cartMap.values.length}');
                  return cartMap.values.isNotEmpty || cartMap == {}
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _cartCubit(context).cartItemModel.cartMap.length,
                          itemBuilder: (context, index) {
                            final _cartMap = context
                                .read<CartCubit>()
                                .cartItemModel
                                .cartMap
                                .values
                                .toList()[index];
                            return CartItem(
                              cartItemModel: _cartMap,
                              onDismissed: (direction) =>
                                  _onDismissed(context, _cartMap.id, index),
                              onPressDecrement: () async => await _cartCubit(context)
                                  .updateQuantity(_cartMap.id, true),
                              onPressIncrement: () async => await _cartCubit(context)
                                  .updateQuantity(_cartMap.id, false),
                            );
                          },
                        )
                      : const EmptyScreen(text: 'Cart Items is Empty');
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: BlocBuilder<CartCubit, CartStates>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      RowTextAndNumber(
                          text: 'Taxes', price: _cartCubit(context).taxesAmount()),
                      const Spacer(),
                      RowTextAndNumber(
                          text: 'Total Before Taxes',
                          price: _cartCubit(context).totalAmountBeforeTaxes()),
                      const Spacer(),
                      RowTextAndNumber(
                          text: 'Total Price',
                          price: _cartCubit(context).totalAmount()),
                      const Spacer(flex: 2),
                    ],
                  );
                },
              ),
            ),
            CustomElevatedButton(
              text: 'Order Now',
              onPressed: () async {
                await _cartCubit(context).clearCartMap();
                _productCubit(context).removeAllInCart();
              },
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class CartHeader extends StatelessWidget {
  const CartHeader({
    super.key,
    required this.isDark,
    this.text = 'Cart',
  });

  final bool isDark;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackIosButton(
            backgroundColor:
                isDark ? AppColor.kBackButtonColor : AppColor.kCoWhiteColor),
        const Spacer(flex: 5),
        Text(text, style: Theme.of(context).textTheme.headline4),
        const Spacer(flex: 7)
      ],
    );
  }
}
