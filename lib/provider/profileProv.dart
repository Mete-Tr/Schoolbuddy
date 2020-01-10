import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProv with ChangeNotifier {
  var user;
  Future<dynamic> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      final tmp = prefs.getString('userData');
      user = json.decode(tmp);
    }
    return user;
  }
}
