import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("https://reqres.in/api/login"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      print('------------>status code: ${response.statusCode}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);
      _isAuthenticated = true;
      notifyListeners();
    } else {
      throw Exception("Login failed");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedIn');
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('loggedIn') ?? false;
    notifyListeners();
  }
}
