import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/cubit/home/categories/categories_cubit.dart';
import 'package:hermoso_store/model/categories_model/categories_data_model.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/empty_screen.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/loading_widget.dart';

import '../../../utils/responsive_size.dart';
import '../../widgets/product_card.dart';
import '../../widgets/show_dialog.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>with ShowAlertMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_categoriesList(context).categoryList.isEmpty) {
      return _categoriesCubit(context).getCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
      listener: (context, state) {
        if (state is CategoriesErrorState) {
          showToast(context, 'Please Check Your Network Connection');
          print('Categories Screen :${state.error.toString()}');
        }
      },
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return const LoadingWidget();
        }

        return state is CategoriesSuccessState
            ? Scaffold(
                body: Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: SizeConfig.getScreenWidth(8)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  _categoriesList(context).categoryList.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => ProductCard(
                                cardIcon: const Icon(null),
                                image:
                                    '${_categoriesList(context).categoryList[index].image}',
                                title:
                                    '${_categoriesList(context).categoryList[index].name}',
                                onPressedFavorite: () {},
                                onTapInkWell: () {},
                                // isFavorite: CategoriesCubit.get(context).changeFavorite(),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              )
            : const EmptyScreen(text: 'Network occur an Error...');
      },
    );
  }

  CategoriesDataModel _categoriesList(context) {
    return _categoriesCubit(context).categoriesModel.data;
  }

  CategoriesCubit _categoriesCubit(context) => CategoriesCubit.get(context);

  void _showMeAlertDialog(BuildContext context, state) {
    showAlertDialog(
      context: context,
      title: state,
      actionButton: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'))
      ],
    );
  }
}
