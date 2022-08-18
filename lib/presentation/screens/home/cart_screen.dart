import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/cubit/global_cubit/cart/cart_cubit.dart';
import 'package:hermoso_store/data/local_data/sqlite_database.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/back_ios_button.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/custom_action_appbar.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/custom_elevated_button.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/empty_screen.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/row_text_and_number.dart';
import 'package:hermoso_store/presentation/widgets/show_snack_bar.dart';

import '../../../cubit/global_cubit/products/products_cubit.dart';
import '../../../cubit/global_cubit/settings/settings_cubit.dart';
import '../../../utils/colors.dart';
import '../../views/cart_item.dart';
import '../../widgets/custom_widgets/loading_widget.dart';

class CartScreen extends StatelessWidget with SnackBarMixin {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart-Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: changeAppAndStatusBarColor(
          isDark: _settingsCubit(context).isDarkMode),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  BackIosButton(
                      backgroundColor: _settingsCubit(context).isDarkMode
                          ? AppColor.kBackButtonColor
                          : AppColor.kCoWhiteColor),
                  const Spacer(flex: 5),
                  Text('Cart', style: Theme.of(context).textTheme.headline4),
                  const Spacer(flex: 7)
                ],
              ),
            ),
            Expanded(
              flex: 14,
              child: BlocBuilder<CartCubit, CartStates>(
                builder: (context, state) {
                  print('cart screen builder is : ${state.toString()}');
                  if (state is CartLoadingState) {
                    return const LoadingWidget();
                  }
                  return _cartCubit(context).cartMap.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _cartCubit(context).cartMap.length,
                          itemBuilder: (context, index)  {
                            final _cartMap = _cartCubit(context)
                                .cartMap
                                .values
                                .toList()[index];
                            return CartItem(
                              cartItemModel: _cartMap ,
                              onDismissed: (direction) {
                                _cartCubit(context).removeItem(_cartMap.id);
                                _productCubit(context)
                                    .toggleCartIcon(index, _cartMap.id);
                                print(_cartCubit(context).cartMap.length);
                              },
                              onPressDecrement: () => _cartCubit(context)
                                  .updateQuantity(_cartMap.id, true),
                              onPressIncrement: () {
                                _cartCubit(context)
                                    .updateQuantity(_cartMap.id, false);
                              },
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
                          text: 'Taxes',
                          price: _cartCubit(context).taxesAmount()),
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
                onPress: () => _cartCubit(context).clearCartMap()),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  CartCubit _cartCubit(context) => BlocProvider.of<CartCubit>(context);

  ProductsCubit _productCubit(context) =>
      BlocProvider.of<ProductsCubit>(context);

  SettingsCubit _settingsCubit(context) =>
      BlocProvider.of<SettingsCubit>(context);


}
