import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/favorite_model/favorite_datum.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitialState());



}
