import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userId;

  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;

  void login(String id) {
    // Temporarily accept any non-empty username and password for testing
    if (id.isNotEmpty) {
      _isLoggedIn = true;
      _userId = id;
      notifyListeners();
    }
  }

  void logout() {
    _isLoggedIn = false;
    _userId = null;
    notifyListeners();
  }
}
