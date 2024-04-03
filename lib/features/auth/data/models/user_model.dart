class UserModel {
  final String name;

  final String email;
  final int id;

  final String token;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      email: json['user']['email'],
      name: json['user']['name'],
      token: json['token'],
    );
  }
}
