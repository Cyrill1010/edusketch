class User {
  final String uid;

  User({this.uid});
}

class Error implements User {
  Error(this.msg);

  final String msg;

  @override
  String get uid => throw UnimplementedError();
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({this.uid, this.sugars, this.strength, this.name});
}
