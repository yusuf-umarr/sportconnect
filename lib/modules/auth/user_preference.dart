import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportconnect/modules/auth/models/user_model.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    var commit = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("phoneNumber", user.phoneNumber);
    prefs.setString("email", user.email);
    prefs.setString("password", user.password);
    prefs.setString("interest", user.interest);
    commit = true;
    return commit;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? phoneNumber = prefs.getString("phoneNumber");
    String? email = prefs.getString("email");
    String? password = prefs.getString("password");
    String? interest = prefs.getString("interest");

    return User(
      phoneNumber: phoneNumber,
      email: email,
      password: password,
      interest: interest,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("phoneNumber");
    prefs.remove("email");
    prefs.remove("password");
    prefs.remove("interest");
  }
}
