import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProv with ChangeNotifier {
  dynamic getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final user = jsonDecode(prefs.getString('userData'));
    return user;
  }
}
