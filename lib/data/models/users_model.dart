class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.birthDate,
    required this.image,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String maidenName;
  late final int age;
  late final String gender;
  late final String email;
  late final String phone;
  late final String username;
  late final String birthDate;
  late final String image;
  bool isAdded = false;

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    maidenName = json['maidenName'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    birthDate = json['birthDate'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['maidenName'] = maidenName;
    _data['age'] = age;
    _data['gender'] = gender;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['username'] = username;
    _data['birthDate'] = birthDate;
    _data['image'] = image;
    return _data;
  }
}
