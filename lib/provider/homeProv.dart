import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeProv with ChangeNotifier {
  //TODO: Token -> problem
  Future<bool> getSubjects(String token) async {
    String url = 'https://schoolbuddy.herokuapp.com/api/sb/subject/';

    final response = await http.get(url, headers: {
      'Authorization': 'token ' + token,
    });
    final tmp = response;
  }
}
