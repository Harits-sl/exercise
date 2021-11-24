import 'package:exercise/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDB {
  static Future<UserModel> saveUser(Map<String, dynamic> user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('id', user['id']);
    prefs.setString('name', user['name']);
    prefs.setString('email', user['email']);
    prefs.setString('avatar', user['avatar']);
    prefs.setString('username', user['username']);
    prefs.setString('token', user['token']);

    Map<String, dynamic> newUser = {
      'id': user['id'],
      'name': user['name'],
      'email': user['email'],
      'avatar': user['avatar'],
      'username': user['username'],
      'token': user['token'],
    };

    UserModel userModel = UserModel.fromMap(newUser);

    return userModel;
  }

  static Future<dynamic> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt('id');
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? avatar = prefs.getString('avatar');
    String? username = prefs.getString('username');
    String? token = prefs.getString('token');

    print(id);

    Map<String, dynamic> user = {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'username': username,
      'token': token,
    };

    UserModel userModel = UserModel.fromMap(user);

    return userModel;
  }

  static void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('avatar');
    prefs.remove('username');
    prefs.remove('token');
  }
}
