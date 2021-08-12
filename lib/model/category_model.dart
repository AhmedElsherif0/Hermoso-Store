class Category {
  int? _id;
  String? _image;
  String? _name;

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get name => _name;
  set name(String? name) => _name = name;

  Category.fromJson(Map<String, dynamic>? json) {
    _id = json?['id'];
    _image = json?['image'];
    _name = json?['name'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['image'] = this._image;
    data['name'] = this._name;
    return data;
  }*/
}