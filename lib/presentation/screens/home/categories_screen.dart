import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/categorry_item_card.dart';
import 'package:hermoso_store/presentation/widgets/show_snack_bar.dart';

import '../../../domain/cubit/global_cubit/categories/categories_cubit.dart';
import '../../widgets/custom_widgets/empty_screen.dart';
import '../../widgets/custom_widgets/loading_widget.dart';
import '../../widgets/show_dialog.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SnackBarMixin, AlertDialogMixin {
  @override
  void didChangeDependencies() {
    if (_categoriesList(context).isEmpty) _categoriesCubit(context).getCategories();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    if (_categoriesList(context).isEmpty) _categoriesCubit(context).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
      listener: (context, state) {
        if (state is CategoriesErrorState) {
          showSnackBar(context, 'Please Check Your Network Connection');
          print('Categories Screen :${state.error.toString()}');
        }
      },
      builder: (context, state) {
        if (state is CategoriesLoadingState) const LoadingWidget();

        return state is CategoriesSuccessState
            ? Scaffold(
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: _categoriesList(context).length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => CategoryItemCard(
                            image: '${_categoriesList(context)[index].image}',
                            title: '${_categoriesList(context)[index].name}',
                            // isFavorite: CategoriesCubit.get(context).changeFavorite(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const EmptyScreen(text: 'Network occur an Error...');
      },
    );
  }

  _categoriesList(context) =>
      _categoriesCubit(context).categoriesModel.data.categoryList;

  CategoriesCubit _categoriesCubit(context) => CategoriesCubit.get(context);
}
