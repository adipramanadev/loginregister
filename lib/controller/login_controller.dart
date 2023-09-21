import 'package:flutter/material.dart';
import 'package:loginregister/model/User.dart';

import 'package:loginregister/service/web_service.dart';

import 'package:loginregister/shared/utils/state.dart';

class LoginController with ChangeNotifier {
  AuthState _state = AuthState.notLoggedIn;
  AuthState get state => _state;

  User _user = User.empty;
  User get user => _user;

  String _message = '';
  String get message => _message;

  void _setState(AuthState state) {
    _state = state;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    Map<String, dynamic> result;

    _setState(AuthState.authenticating);
    var data = await WebService.login(username, password);

    if (data['status']) {
      _user = data['data'];
      _message = data['message'];
      result = {'status': data['status']};
      // UserPreferences().saveUser(_user);
      _setState(AuthState.loggedIn);
      notifyListeners();
    } else {
      _message = data['message'];
      result = {'status': data['status']};
      _setState(AuthState.notLoggedIn);
      notifyListeners();
    }
    return result;
  }
}
