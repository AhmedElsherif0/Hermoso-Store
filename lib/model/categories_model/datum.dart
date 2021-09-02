class Datum {
  int? _id;
  String? _name;
  String? _image;

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  Datum.fromJson(Map<String, dynamic> json) {
    _id= json["id"];
    _name= json["name"];
    _image= json["image"];
  }

  Map<String, dynamic> toJson() => {
    "id": _id,
    "name": _name,
    "image": _image,
  };

  String? get name => _name;

  String? get image => _image;

  set image(String? value) {
    _image = value;
  }

  set name(String? value) {
    _name = value;
  }
}