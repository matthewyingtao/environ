class UserModel {
  UserModel({required this.uid});

  final String uid;
}

class UserData {
  UserData({
    required this.uid,
    required this.name,
    required this.sugars,
    required this.strength,
  });

  final String uid;
  final String name;
  final String sugars;
  final int strength;
}
