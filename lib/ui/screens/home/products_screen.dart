import 'package:firstdesign/cubit/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeErrorState) {
          print('products Screen :${state.message.toString()}');
        }
      },
      builder: (context, state) {
        if (state is HomeSuccessState) {
          final _state = state.model.data;
          return Center(
            child: Column(children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  itemCount: _state!.banners!.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Card(
                        child: Image(
                          image: NetworkImage('${_state.products?[index].image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 250.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          );
        }
        return Center(child: Container(),);
      },
    );
  }
}
