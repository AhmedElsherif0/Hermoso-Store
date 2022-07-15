
import 'favorite_data.dart';
import 'favorite_model.dart';

class FavoriteBase extends FavoriteModel {
  FavoriteData favoriteData = FavoriteData();

  FavoriteBase();

  FavoriteBase.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    favoriteData =
        (json["data"] != null ? FavoriteData.fromJson(json["data"]) : null)!;
  }
}
