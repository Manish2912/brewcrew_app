class User {
  final String uid;

  User({this.uid});
}

// here we have created user data model for each user document

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({this.uid, this.sugars, this.strength, this.name});
}
