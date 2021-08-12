class UserData {
  int? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _image;
  int? _points;
  int? _credit;
  String? _token;

  UserData(this._id , this._name, this._email, this._phone, this._image,
      this._points, this._credit, this._token);

  int? get id => _id;

  UserData.fromJson(Map<String ,dynamic>? json){
      _id = json?['id'];
      _name = json?['name'];
      _email = json?['email'];
      _phone = json?['phone'];
      _image = json?['image'];
      _points = json?['points'];
      _credit = json?['credit'];
      _token = json?['token'];
    }

    String? get name => _name;

  String? get token => _token;

  int? get credit => _credit;

  int? get points => _points;

  String? get image => _image;

  String? get phone => _phone;

  String? get email => _email;
}
