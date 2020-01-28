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
DateTime _expiryDate;
Timer _authTimer;
bool _seen = false;
List<int> myCoureses = [];

class AuthProv with ChangeNotifier {
  bool get isAuth {
    if (_token != null)
      return true;
    else
      return false;
  }

  bool get isSeen {
    return _seen;
  }

  bool addToCourseList(int courseID) {
    myCoureses.add(courseID);
    // print(myCoureses);
    return true;
  }

  bool removeFromCourseList(int courseID) {
    myCoureses.remove(courseID);
    // print(myCoureses);
    return true;
  }

  Future<bool> setSeenTrue() async {
    final url = 'https://schoolbuddy.herokuapp.com/api/user/me/';

    final prefs = await SharedPreferences.getInstance();

    final response = await http.patch(url, headers: {
      'Authorization': 'token ' + _token,
    }, body: {
      'seen': 'true'
    });
    _seen = true;
    prefs.setBool('seen', _seen);
    notifyListeners();
    return true;
  }

  Future<List> setMyCourses() async {
    final url = 'https://schoolbuddy.herokuapp.com/api/user/me';

    List sta;
    //TODO: error -> erwartet String, not working
    final response = await http.patch(
      url,
      headers: {
        'Authorization': 'token ' + _token,
        'Content-type': 'application/json'
      },
      body: '{course: $myCoureses} ',
    );
    print(myCoureses);
    print(response.body);
    final tmp = response;
    return sta;
  }

  Future<bool> setClass(String klasse) async {
    final url = 'https://schoolbuddy.herokuapp.com/api/user/me/';

    final respone = await http.patch(url, headers: {
      'Authorization': 'token ' + _token,
    }, body: {
      'klasse': klasse,
    });
    return true;
  }

  Future<bool> changePwd(String oldPwd, String newPwd) async {
    //TODO: if satuscode != 200
    final url = 'https://schoolbuddy.herokuapp.com/api/user/password_update/';

    final response = await http.put(url, headers: {
      'Authorization': 'token ' + _token,
    }, body: {
      'old_password': oldPwd,
      'new_password': newPwd,
    });
    // logout();
    return true;
  }

  Future<bool> changeEmail(String pwd, String email) async {
    //TODO: if satuscode != 200
    final url = 'https://schoolbuddy.herokuapp.com/api/user/update_email/';

    final response = await http.put(url, headers: {
      'Authorization': 'token ' + _token,
    }, body: {
      'password': pwd,
      'email': email
    });
    // logout();
    return true;
  }

  Future<bool> changeName(String fullName) async {
    final url = 'https://schoolbuddy.herokuapp.com/api/user/me/';
    final prefs = await SharedPreferences.getInstance();
    List<String> name = fullName.split(' ');

    final response = await http.patch(url, headers: {
      'Authorization': 'token ' + _token,
    }, body: {
      'firstname': name[0],
      'lastname': name[1],
    });
    prefs.setString('firstname', name[0]);
    prefs.setString('lastname', name[1]);
    // logout();
    return true;
  }

  Future<bool> signUp(
      String email, String password, String vorname, String nachname) async {
    final url = 'https://schoolbuddy.herokuapp.com/api/user/create/';

    final response = await http.post(url, body: {
      'email': email,
      'firstname': vorname,
      'lastname': nachname,
      'password': password,
    });
    if (response == null)
      return false;
    else
      return true;
  }

  Future<List> getClasses() async {
    final url = 'https://schoolbuddy.herokuapp.com/api/sb/klasse/';

    final response = await http.get(url);
    final tmp = json.decode(response.body);
    List tmp2 = tmp['results'];
    List<String> list = List<String>(tmp2.length);
    for (int i = 0; i < tmp2.length; i++) {
      list[i] = tmp2[i]['klasse_name'];
    }
    return list;
  }

  Future<List<dynamic>> getCourses(String klasse) async {
    final url = 'https://schoolbuddy.herokuapp.com/api/sb/course/';

    final response = await http.get(url, headers: {
      'Authorization': 'token ' + _token,
    });
    final tmp = json.decode(response.body);
    List<dynamic> tmp2 = tmp['results'];
    return tmp2;
  }

  Future<bool> addFcmDevice(String fcmToken) async {
    String deviceName;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    var build = await deviceInfoPlugin.androidInfo;
    deviceName = build.model;
    identifier = build.androidId;

    final url = 'https://schoolbuddy.herokuapp.com/api/sb/device/';

    final response = await http.post(url, headers: {
      'Authorization': 'token ' + _token,
    }, body: {
      'name': deviceName,
      'active': 'true',
      'device_id': identifier,
      'registration_id': fcmToken,
      'type': 'android',
      'user': '$_email'
    });
    if (response == null)
      return false;
    else
      return true;
  }

  Future<bool> signIn(String email, String password) async {
    String url = 'https://schoolbuddy.herokuapp.com/api/user/token/';

    final tmp = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    final tmp2 = json.decode(tmp.body);
    _token = tmp2['token'];

    url = 'https://schoolbuddy.herokuapp.com/api/user/me';
    final response = await http.get(url, headers: {
      'Authorization': 'token ' + _token,
    });

    final signinData = (json.decode(response.body)) as Map<String, dynamic>;
    _firstname = signinData['firstname'];
    _lastname = signinData['lastname'];
    _email = signinData['email'];
    _klasse = signinData['klasse'];
    _seen = signinData['seen'];
    _expiryDate = DateTime.now().add(
      Duration(hours: 2),
    );

    _autoLogout();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token);
    prefs.setString('firstname', _firstname);
    prefs.setString('lastname', _lastname);
    prefs.setString('email', _email);
    prefs.setString('klasse', _klasse);
    prefs.setString('expiryDate', _expiryDate.toIso8601String());
    prefs.setBool('seen', _seen);
    notifyListeners();
    if (response == null)
      return false;
    else
      return true;
  }

  Future<bool> logout() async {
    _token = null;
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
    if (_token != null)
      return false;
    else
      return true;
  }

  Future<bool> tryAutoLogin() async {
    final p = await SharedPreferences.getInstance();
    if (!p.containsKey('token')) {
      return false;
    }

    final expiryDate = DateTime.parse(p.getString('expiryDate'));

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = p.getString('token');
    _expiryDate = expiryDate;
    _email = p.getString('email');
    _firstname = p.getString('firstname');
    _lastname = p.getString('lastname');
    _klasse = p.getString('klasse');
    _seen = p.getBool('seen');
    _autoLogout();
    notifyListeners();
    return true;
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
