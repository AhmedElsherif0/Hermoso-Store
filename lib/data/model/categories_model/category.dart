class Category {
  int? id;
  String? name;
  String? image;


  Category.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "image": image,
      };
}