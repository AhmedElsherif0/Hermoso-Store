import 'favorite_datum.dart';

class FavoriteData {
  late int currentPage;
  List<FavoriteList> favoriteList = [];

  FavoriteData();

  FavoriteData.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    favoriteList = json["data"]
        .map<FavoriteList>((v) => FavoriteList.fromJson(v)).toList();
  }
}
