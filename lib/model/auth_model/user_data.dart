class UserData {
  int? id;
  String name = 'EmptyName';
  String email = 'Empty@email.com';
  String? phone;
  String image = 'assets/product-placeholder.png';
  int? points;
  int? credit;
  String? token;

  UserData();

  UserData.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    image = json?['image'];
    points = json?['points'];
    credit = json?['credit'];
    token = json?["token"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "points": points,
        "credit": credit,
        "token": token,
      };
}
