import 'dart:convert';

import 'package:exercise/firebase/crashlytics.dart';
import 'package:exercise/models/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Future<AuthModel> signIn(mapEmailAndPassword) async {
    try {
      var apiResult = await http.post(
        Uri.parse('https://bwasandbox.com/api/login'),
        body: jsonEncode(mapEmailAndPassword),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );

      var data = jsonDecode(apiResult.body);
      AuthModel user = AuthModel.fromJson(data);

      return user;
    } catch (err, stackTrace) {
      print(err);
      Crashlytics.recordError(err, stackTrace, 'error in api');
      throw err;
    }
  }
}
