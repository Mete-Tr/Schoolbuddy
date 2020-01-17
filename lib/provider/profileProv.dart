import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProv with ChangeNotifier {
  Future<SharedPreferences> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
