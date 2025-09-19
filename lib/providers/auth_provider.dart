import 'dart:convert';
import 'package:flutter/material.dart';
import '../core/api_client.dart';

class AuthProvider with ChangeNotifier {
  final ApiClient api = ApiClient(baseUrl: 'https://flutter-amr.noviindus.in/api/');
  String? _token;
  bool isLoading = false;

  String? get token => _token;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    notifyListeners();
    final response = await api.postForm('login', {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['token'];
      if (_token != null) {
        api.updateToken(_token!);
        isLoading = false;
        notifyListeners();
        return true;
      }
    }
    isLoading = false;
    notifyListeners();
    return false;
  }
}
