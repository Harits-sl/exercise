import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String avatar;
  final String username;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.username,
    required this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      avatar: map['avatar'],
      username: map['username'],
      token: map['token'],
    );
  }

  @override
  List<Object?> get props => [id, name, email, avatar, username, token];
}
