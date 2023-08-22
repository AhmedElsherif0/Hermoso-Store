

class FavoriteModel {
  bool? status;
  String? message;

  FavoriteModel();

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}