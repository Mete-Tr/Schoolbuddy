import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProv with ChangeNotifier {
  var user;
  Future<SharedPreferences> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    // if (prefs.containsKey('userData')) {
    //   final tmp = prefs.getString('userData');
    //   user = json.decode(tmp);
    // }
    return prefs;
  }
}
