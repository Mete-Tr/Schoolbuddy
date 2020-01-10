import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProv with ChangeNotifier {
  Future<dynamic> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final tmp = prefs.getString('userData');
    final user = json.decode(tmp);
    return user;
  }
}
