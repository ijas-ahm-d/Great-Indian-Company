import 'package:flutter/material.dart';
import 'package:great_gpt/utils/global_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  AuthViewModel() {
    checkSign();
  }
  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isLoggedIn = s.getBool(GlobalKeys.userLoggedInLey) ?? false;
    notifyListeners();
  }

  signOutStatus() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool(GlobalKeys.userLoggedInLey, false);
    notifyListeners();
  }
}
