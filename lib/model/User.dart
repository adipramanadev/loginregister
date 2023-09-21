class User {
  String username;
  String email;
  String firstName;
  String lastName;

  String image;
  String uid;

  User(
      {required this.username,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.image,
      required this.uid});
  static User empty = User(
      username: '', email: '', firstName: '', lastName: '', image: '', uid: '');

  factory User.fromJson(Map<String, dynamic> json) => User(
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
      uid: json['uid']);
}
