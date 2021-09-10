import 'package:hermoso_store/cubit/home/products/products_cubit.dart';
import 'package:hermoso_store/ui/widgets/animated_swiper.dart';
import 'package:hermoso_store/ui/widgets/product_card.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductsErrorState) {
          print('products Screen :${state.message.toString()}');
        }
      },
      builder: (context, state) {
        if (state is ProductsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductsSuccessState) {
          final banners = state.model.data!.banners;
          final products = state.model.data!.products;
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getScreenWidth(8)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AnimationSwiper(
                        itemBuilder: (context, index) {
                          return FadeInImage(
                            placeholder:
                                const AssetImage('assets/product-placeholder.png'),
                            image: NetworkImage('${banners![index].image}'),
                            fit: BoxFit.cover,
                          );
                        },
                        itemLength: banners!.length,
                      ),
                    ),
                    SizedBox(height: getScreenHeight(24)),
                    const Text(
                      'Recent Item',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 4,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: products!.length,
                        itemBuilder: (context, index) => ProductCard(
                          image: '${products[index].image}',
                          title: '${products[index].name}',
                          price: products[index].price,
                          oldPrice: products[index].oldPrice,
                          // isFavorite: ProductsCubit.get(context).changeFavorite(),
                        ),
                      ), //ListView.builder(
                    ),
                  ]),
            ),
          );
        }
        return const Center(
            child: Text('Something went \n wrong...',
                textAlign: TextAlign.center));
      },
    );
  }
}
