class Category {
  int? id;
  String? image;
  String? name;


  Category.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    image = json?['image'];
    name = json?['name'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['image'] = this._image;
    data['name'] = this._name;
    return data;
  }*/
}