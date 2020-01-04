import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

String _token;
String _firstname;
String _lastname;
String _email;
String _klasse;
int _id;
DateTime _expiryDate;
Timer _authTimer;

class AuthProv with ChangeNotifier {
  bool get isAuth {
    return _token != null;
  }

  Future<void> signUp(String email, String password, String vorname,
      String nachname, String klasse) async {
    final url = 'https://schoolbuddy.herokuapp.com/api/user/create/';

    final response = await http.post(
      url,
      body: {
        'email': email,
        'firstname': vorname,
        'lastname': nachname,
        'password': password,
        'klasse': klasse,
      },
    );
  }

  Future<void> signIn(String email, String password) async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    var build = await deviceInfoPlugin.androidInfo;
    deviceName = build.model;
    deviceVersion = build.version.toString();
    identifier = build.androidId;

    final url = 'https://schoolbuddy.herokuapp.com/api/user/token/';

    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    final signinData = (json.decode(response.body)) as Map<String, dynamic>;
    _token = signinData['token'];
    _id = signinData['user_id'];
    _firstname = signinData['firstname'];
    _lastname = signinData['lastname'];
    _email = signinData['email'];
    _klasse = signinData['klasse'];
    _expiryDate = DateTime.now().add(
      Duration(hours: 2),
    );

    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'id': _id,
      'firstname': _firstname,
      'lastname': _lastname,
      'email': _email,
      'klasse': _klasse,
      'expiryDate': _expiryDate.toIso8601String(),
    });
    prefs.setString('userData', userData);
  }

  Future<void> logout() async {
    _token = null;
    _id = null;
    _lastname = null;
    _firstname = null;
    _expiryDate = null;
    _email = null;
    _klasse = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUser =
        json.decode(prefs.getString('userData')) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUser['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUser['token'];
    _expiryDate = expiryDate;
    _email = extractedUser['email'];
    _firstname = extractedUser['firstname'];
    _lastname = extractedUser['lastname'];
    _id = extractedUser['id'];
    _klasse = extractedUser['klasse'];
    notifyListeners();
    _autoLogout();
    return true;
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  int get getId {
    return _id;
  }
}
