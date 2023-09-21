import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:loginregister/model/User.dart';

class WebService {
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    Map<String, dynamic> result;
    Uri url = Uri.parse('https://dummyjson.com/auth/login');
    Map<String, String> data = {'username': username, 'password': password};
    try {
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        User user = User.fromJson(json.decode(response.body));
        result = {'status': true, 'data': user, 'message': 'Success'};
      } else {
        String message = '${json.decode(response.body)['message']}';
        result = {
          'status': false,
          'message': 'Logged in failed',
          'data': message,
        };
      }
    } on SocketException {
      result = {
        'status': false,
        'message': 'No internet connection',
        'data': null,
      };
    }
    return result;
  }
}
